From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi_bitbang cs_change hinting fix
Date: Tue, 11 Mar 2008 11:05:51 +0100
Message-ID: <47D6597F.4040503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040502000407070502090003"
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
--------------040502000407070502090003
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Fix condition for deactivating chipselect after processing of
spi_message - if cs_change==0, chipselect should not be touched and left
active for next spi_message to follow.

Signed-off-by: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---

I am not sure about the meaning of spi message transfer cs_change attribute.

I assume that non-zero cs_change indicate that chipselect should be
toggled between spi_transfers.

What about cs_change in last spi_transfer of spi_message?
Should zero cs_change provide hinting that chipselect should be left
active, because spi_message to follow will be for the same spi device?

If that is so, the handling in spi_bitbang.c would be incorrect, because
chipselect would be deactivated when cs_change==0.

Or is the meaning of cs_change in the last spi_transfer of spi_message
different than in previous spi_transfers in single spi_message?
Like cs_change==0 in last spi_transfer would indicate to deactivate
chipselect and cs_change!=0 in last spi_transfer would provide hinting
that next spi_message will be for the same spi device and chipselect
should be left active?
If that is so, it's quite confusing (and not documented), as the meaning
of cs_change in the last spi_transfer would be opposite than in other
spi_transfers in single spi_message.

The patch here fixes the condition for the case that cs_change meaning
is the first variant described.

 spi_bitbang.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--------------040502000407070502090003
Content-Type: text/plain;
 name="spi_bitbang-cs_change-hinting-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="spi_bitbang-cs_change-hinting-fix.patch"

diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index f7f8580..7ff31a3 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -380,7 +380,7 @@ static void bitbang_work(struct work_struct *work)
 		 * cs_change has hinted that the next message will probably
 		 * be for this chip too.
 		 */
-		if (!(status == 0 && cs_change)) {
+		if (!(status == 0 && !cs_change)) {
 			ndelay(nsecs);
 			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
 			ndelay(nsecs);

--------------040502000407070502090003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------040502000407070502090003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------040502000407070502090003--
