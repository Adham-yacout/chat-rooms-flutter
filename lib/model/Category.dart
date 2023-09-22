class Category{
  static const String sportsid='sports';
  static const String moviesid='movies';
  static const String musicid='music';

  String id;
  late String title;

  late String image;
  Category({required this.id,required this.title, required this.image});
  Category.fromId(this.id)
  {
    if(id==sportsid)
      {
        title='sports';
        image='assets/images/sports.png';
      }
    else if(id== moviesid)
      {
        title='movies';
        image='assets/images/movies.png';
      }
    else if(id== musicid)
    {
      title='music';
      image='assets/images/music.png';
    }

    }
    static List<Category> getCategory(){
    return [
      Category.fromId(sportsid),
      Category.fromId(moviesid),
      Category.fromId(musicid),
    ];
    }
  }

