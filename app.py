from werkzeug.contrib.fixers import ProxyFix
from flask.ext.mysqldb import MySQL
from flask.ext.bcrypt import Bcrypt
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
#	app.config['MYSQL_CHARSET'] = 'utf-8'

@app.route('/', methods=['GET', 'POST'])
def login():
	if request.method == 'POST':
		cur = mysql.connection.cursor()
		cur.execute('''SELECT password FROM users WHERE username = \"%s\" ''' %request.form['username'])
		entries = [dict(password=row[0]) for row in cur.fetchall()]

		if entries != [] and request.form['username'] != None and request.form['password'] != None:
			pw_hash = entries[0]['password']
			if bcrypt.check_password_hash(pw_hash, request.form['password']):
			    session['name'] = request.form['username']
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
			cur.execute('''INSERT INTO users VALUES (%s, %s) ''', (request.form['username'], pw_hash))
			mysql.connection.commit()
			return redirect(url_for('login'))
		else:
			return render_template('signUp.html', msg = "Passwords do not match")
	else:
    		return render_template('signUp.html')

@app.route('/menu')
def show_menu():
    return render_template('menu.html')

@app.route('/events', methods=['GET', 'POST'])
def show_events():
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
        	cur.execute('''SELECT * FROM events''')
        	entries = [dict(event_id=row[0], event_name=row[1]) for row in cur.fetchall()]
            	return render_template('show_events.html', entries=entries)

@app.route('/clear')
def clearsession():
    # Clear the session
    session.clear()
    # Redirect the user to the main page
    return redirect(url_for('login'))

app.wsgi_app = ProxyFix(app.wsgi_app)

if __name__ == '__main__':

        app.run(debug=True,
        host="0.0.0.0",
    port=int("5000"))
