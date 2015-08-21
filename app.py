from werkzeug.contrib.fixers import ProxyFix
from flask.ext.mysqldb import MySQL
from flask.ext.bcrypt import Bcrypt
from flask.ext.mail import Mail, Message
from flask import Flask, request, session, g, redirect, url_for, \
     abort, render_template, flash

app = Flask(__name__)
bcrypt = Bcrypt(app)
app.config.from_object(__name__)

app.secret_key = 'd4rthV4d3rIsYourF4th3r'

mysql = MySQL(app)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_PORT'] = 3306
app.config['MYSQL_USER'] = 'tarcode'
app.config['MYSQL_PASSWORD'] = 'coder123'
app.config['MYSQL_DB'] = 'psytrancr'

app.config['MAIL_SERVER']='smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = 'psytrancrapp@gmail.com'
app.config['MAIL_PASSWORD'] = 'kanqxjdmrqinukjn'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True

mail = Mail(app)
#app.config['DEFAULT_MAIL_SENDER'] =  None

#	app.config['MYSQL_CHARSET'] = 'utf-8'

@app.route('/', methods=['GET', 'POST'])
def login():
	if request.method == 'POST':
		cur = mysql.connection.cursor()
		cur.execute('''SELECT password, username FROM users WHERE username = (%s) OR email = (%s)''', (request.form['username'],request.form['username']))
		entries = [dict(password=row[0], username=row[1]) for row in cur.fetchall()]

		if entries != [] and request.form['username'] != None and request.form['password'] != None:
			pw_hash = entries[0]['password']
			if bcrypt.check_password_hash(pw_hash, request.form['password']):
			    session['name'] = entries[0]["username"]
			    # And then redirect the user to the main page
			    return redirect(url_for('show_menu'))
			elif request.form['password'] != entries[0]['password']:
				return render_template('login.html', msg = "Incorrect Login")
	    	else:
	    		return render_template('login.html', msg = "Incorrect Login")
	else:
		if session:
			return redirect(url_for('show_menu'))
		else:
			return render_template('login.html')
	    		return render_template('login.html')

@app.route('/signUp', methods = ['GET', 'POST'])
def signUp():
    if request.method == 'POST':
        if(request.form['password'] == request.form['password2']):
            pw_hash = bcrypt.generate_password_hash(request.form['password'],10)
            cur = mysql.connection.cursor()
            cur.execute('''INSERT INTO users VALUES (%s, %s, %s) ''', (request.form['username'], request.form['email'], pw_hash))
            mysql.connection.commit()
            msg = Message("Please confirm email address!", sender="psytrancrapp@gmail.com", recipients=[request.form['email']])
            mail.send(msg)
            return render_template('login.html', msg = "Successfully Signed Up")
        else:
			return render_template('signUp.html', msg = "Passwords do not match")
    else:
    		return render_template('signUp.html')

@app.route('/home')
def show_menu():
    cur = mysql.connection.cursor()
    cur.execute('''SELECT events.event_id, img_url, event_name FROM events, event_info, links WHERE events.event_info_id = event_info.id AND events.event_id = links.event_id''')
    entries = [dict(event_id=row[0], img_url=row[1], event_name=row[2]) for row in cur.fetchall()]
    return render_template('menu.html', entries=entries)

@app.route('/events/<int:event_id>', methods=['GET', 'POST'])
def show_events(event_id):
    if request.method == 'POST':
    	if(request.form['event_name'] != ""):
    			cur = mysql.connection.cursor()
    			cur.execute('''INSERT INTO events SET event_name = \"%s\" ''' %(request.form['event_name']))
    			mysql.connection.commit()
    			return redirect(url_for('show_events'))
        else:
                cur = mysql.connection.cursor()
            	cur.execute('''SELECT * FROM events''')
            	entries = [dict(event_id=row[0], event_name=row[1]) for row in cur.fetchall()]
                return render_template('show_events.html', entries=entries, msg = "field cannot be blank")
    else:
        	cur = mysql.connection.cursor()
        	cur.execute('''SELECT img_url, event_name, startDate, endDate, venue, about, facebook, tickets FROM events, event_info, links WHERE events.event_id = \"%s\" AND events.event_info_id = event_info.id AND events.event_id = links.event_id''' %(event_id))
                entries = [dict(img_url=row[0], event_name=row[1], startDate=row[2], endDate=row[3], venue=row[4], about=row[5], facebook=row[6], tickets=row[7]) for row in cur.fetchall()]
                cur.execute('''SELECT artist, artist_link, artist_img FROM artists WHERE artists.event_id = \"%s\"''' %(event_id))
                artists = [dict(artist=row[0], artist_link=row[1], artist_img=row[2]) for row in cur.fetchall()]
        	return render_template('show_events.html', entries=entries, artists=artists)

@app.route('/clear')
def clearsession():
    # Clear the session
    session.clear()
    # Redirect the user to the main page
    return redirect(url_for('login'))

app.wsgi_app = ProxyFix(app.wsgi_app)

if __name__ == '__main__':

        app.run(debug=True,
        host= "0.0.0.0",
    port=int("5000"))
