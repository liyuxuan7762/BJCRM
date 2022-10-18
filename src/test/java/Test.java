import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

public class Test {
    public static void main(String[] args) throws NoSuchFieldException, IllegalAccessException {
        List list = new ArrayList<>();
        list.add(new Student("jkakc", "12"));
        list.add(new Student("2314", "13"));

        Field[] declaredFields = list.get(0).getClass().getDeclaredFields();

        for(int i = 0; i < list.size(); i++) {
            Object o = list.get(i);
            for (Field field : declaredFields) {
                String name = o.getClass().getDeclaredField(field.getName()).get(o).toString();
                System.out.print(field.getName() + ":" + name);
            }
            System.out.println();
        }





    }
}
class Student  {
    String name;
    String age;
    public Student(String name, String age) {
        this.name = name;
        this.age = age;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }
}