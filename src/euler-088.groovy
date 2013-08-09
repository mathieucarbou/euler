final int SIZE = 12000;
final int RANGE = 24000; //P.S. RANGE can be smaller, down to 12,200

int[] k = new int[SIZE + 1];
List<Set<Integer>> nums = new ArrayList<Set<Integer>>(RANGE + 1);
for (int i = 0; i <= RANGE; i++) nums.add(new HashSet<Integer>());

//dynamically calculate all the k's
for (int i = 2; i <= RANGE / 2; i++) {
    nums.get(i).add(-i + 1);

    for (int num : nums.get(i)) {
        int current = i + i;
        int new_num = num - 1;

        for (int j = 2; j <= i && current <= RANGE; j++) {
            nums.get(current).add(new_num);
            int pk = current + new_num;
            if (pk <= SIZE && (current < k[pk] || k[pk] == 0)) k[pk] = current;
            new_num--;
            current += i;
        }
    }
}

//show the answer
boolean success = true;
for (int i = 2; i < k.length; i++) if (k[i] == 0) success = false;
if (success) {
    println k
    k = (k as List).unique().sort();
    int sum = 0;
    for (int i : k) sum += i;
    System.out.println(sum);
}
