from setuptools import setup

setup(
    name='bsdnews',
    version='1.1',
    description='BSD News Reader Script',
    author='Laurent Chardon',
    author_email='laurent.chardon@gmail.com',
    url='https://github.com/LaurentChardon/bsdnews',
    license='BSD 3-Clause License',
    py_modules=['bsdnews'],
    install_requires=[
        'requests',
        'feedparser',
        'beautifulsoup4',
        'blessed',
    ],
    entry_points={
        'console_scripts': [
            'bsdnews=bsdnews:main',
        ],
    },
    include_package_data=True,
)
