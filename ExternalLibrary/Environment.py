dev={'browser':'chrome','url':'https://opensource-demo.orangehrmlive.com/web/index.php/auth/login'}
sit={'browser':'firefox','url':'https://opensource-demo.orangehrmlive.com/web/index.php/auth/login'}
prod={'browser':'safari','url':'https://opensource-demo.orangehrmlive.com/web/index.php/auth/login'}

def select_environment(env):
    if env=="dev":
        return dev
    elif env=="sit":
        return sit
    else:
        return {}
