make -B
for i in 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 019 020 021 022 023 024 025 026 027 028 031 032
do
        ./latc lattests/good/core$i.lat
        ./lattests/good/core$i > oucik
        diff oucik lattests/good/core$i.output
done

rm oucik

for i in 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027
do
        echo $i
        ./latc lattests/bad/core$i.lat
        ./lattests/good/core$i
done
