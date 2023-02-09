if __name__ == "__main__":
    print(
"""
Project '{{cookiecutter.project_name}}' is created. Next steps:
    * cd ./{{cookiecutter.project_slug}}
    * cp .env.template .env
    * Adjust .env
    * ./manage.sh init
    * Adjust django settings
    * ./manage.sh dj migrate
    * ./manage.sh run
""")
