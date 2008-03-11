From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi_bitbang: txrx_bufs zero status fix
Date: Tue, 11 Mar 2008 11:05:10 +0100
Message-ID: <47D65956.9070205@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090709070509050509020203"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--------------090709070509050509020203
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

SPI controller drivers return number of bytes actually transfered from
bitbang->txrx_bufs() method. Returned zero number of bytes transfered
when non-zero number of bytes to transfer was requested should be
recognized as error.
The patch fixes that.

Signed-off-by: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---

 spi_bitbang.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--------------090709070509050509020203
Content-Type: text/plain;
 name="spi_bitbang-txrx_bufs-zero-status-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="spi_bitbang-txrx_bufs-zero-status-fix.patch"

diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index f7f8580..83c911b 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -345,7 +345,9 @@ static void bitbang_work(struct work_struct *work)
 				status = bitbang->txrx_bufs(spi, t);
 			}
 			if (status != t->len) {
-				if (status > 0)
+				/* zero status, meaning zero number of bytes
+				 * transfered, is also invalid in this case */
+				if (status >= 0)
 					status = -EMSGSIZE;
 				break;
 			}

--------------090709070509050509020203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------090709070509050509020203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------090709070509050509020203--
