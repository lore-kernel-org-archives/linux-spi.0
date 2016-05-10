From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH -trivial 1/3] Documentation: vm: Spelling s/paltform/platform/g
Date: Tue, 10 May 2016 20:59:56 +0200
Message-ID: <1462906798-27993-1-git-send-email-geert+renesas@glider.be>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 Documentation/vm/hugetlbpage.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/hugetlbpage.txt b/Documentation/vm/hugetlbpage.txt
index 54dd9b9c6c31aeed..6f3b3fa35613d900 100644
--- a/Documentation/vm/hugetlbpage.txt
+++ b/Documentation/vm/hugetlbpage.txt
@@ -275,10 +275,10 @@ This command mounts a (pseudo) filesystem of type hugetlbfs on the directory
 options sets the owner and group of the root of the file system.  By default
 the uid and gid of the current process are taken.  The mode option sets the
 mode of root of file system to value & 01777.  This value is given in octal.
-By default the value 0755 is picked. If the paltform supports multiple huge
+By default the value 0755 is picked. If the platform supports multiple huge
 page sizes, the pagesize option can be used to specify the huge page size and
 associated pool.  pagesize is specified in bytes.  If pagesize is not specified
-the paltform's default huge page size and associated pool will be used. The
+the platform's default huge page size and associated pool will be used. The
 size option sets the maximum value of memory (huge pages) allowed for that
 filesystem (/mnt/huge).  The size option can be specified in bytes, or as a
 percentage of the specified huge page pool (nr_hugepages).  The size is
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
