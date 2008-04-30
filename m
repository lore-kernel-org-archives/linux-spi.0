From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: mmc_spi.c driver
Date: Tue, 29 Apr 2008 17:38:34 -0700
Message-ID: <200804291738.34965.david-b@pacbell.net>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com>
	<20080424140541.773f6e6b@mjolnir.drzeus.cx>
	<200804291708.09424.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200804291708.09424.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
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

On Tuesday 29 April 2008, David Brownell wrote:
> =

> > > mmc0: error -22 whilst initialising SDIO card =A0
> > =

> > This is a bit odd. It shouldn't have gone down that route unless it is
> > sure it's an SDIO card it is dealing with.
> =

> I've seen that in the past, I forget why. =A0It may have been the
> problem with cards that didn't like to respond to certain requests
> while they're resetting ... the problem which ensures that I must
> always use the appended patch, since you didn't want to merge it.
> =


When enumerating MMC cards using SPI, don't support the "just probe"
mechanism since it doesn't always work.  Instead, always wait for the
reset to complete before issuing the next request.  (Failed on an
otherwise trusty SanDisk MMC card...)

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/mmc/core/mmc_ops.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/mmc/core/mmc_ops.c	2007-11-05 18:17:50.000000000 -0800
+++ b/drivers/mmc/core/mmc_ops.c	2007-11-05 18:24:32.000000000 -0800
@@ -114,8 +114,11 @@ int mmc_send_op_cond(struct mmc_host *ho
 		if (err)
 			break;
 =

-		/* if we're just probing, do a single pass */
-		if (ocr =3D=3D 0)
+		/* if we're just probing, do a single pass ... except,
+		 * accomodate cards which don't behave right until a
+		 * SPI reset completes.
+		 */
+		if (ocr =3D=3D 0 && !mmc_host_is_spi(host))
 			break;
 =

 		/* otherwise wait until reset completes */


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
