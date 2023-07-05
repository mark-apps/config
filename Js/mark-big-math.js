var MarkBigMath = {
      //加法
        add: function (v1, v2) {
            var r1, r2, m;
            try { r1 = String(v1).split(".")[1].length; } catch (e) { r1 = 0; }
            try { r2 = String(v2).split(".")[1].length; } catch (e) { r2 = 0; }
            m = Math.pow(10, Math.max(r1, r2));
            return (v1 * m + v2 * m) / m;
        },

        //减法
        sub: function (v1, v2) {
            return this.accAdd(v1, -v2);
        },

        //乘法
        multi: function (v1, v2) {
            var m = 0, s1 = String(v1), s2 = String(v2);
            try { m += s1.split('.')[1].length } catch (e) {}
            try { m += s2.split('.')[1].length } catch (e) {}
            return Number(s1.replace('.', '')) * Number(s2.replace('.', '')) / Math.pow(10, m);
        },

        //除法
        div: function (v1, v2) {
            var t1 = 0, t2 = 0, s1 = String(v1), s2 = String(v2);
            try { t1 = s1.split(".")[1].length; } catch (e) {}
            try { t2 = s2.split(".")[1].length; } catch (e) {}
            s1 = Number(s1.replace('.', ''));
            s2 = Number(s2.replace('.', ''));
            return (s1 / s2) * Math.pow(10, t2 - t1);
        }
}

//示例 
var add = MarkBigMath.add(0.1,0.2);
console.log("add==" + add);

var sub = MarkBigMath.sub(1,0.8); 
console.log("sub==" + sub);


