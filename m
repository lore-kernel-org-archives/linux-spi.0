From: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [spi][mpc52xx][PATCH] Fix mpc52xx_psc_spi
	master driver
Date: Fri, 25 Jul 2008 13:43:41 +0200
Message-ID: <20080725114341.GB6415@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0113562033=="
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
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


--===============0113562033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline


--vEao7xgI/oilGqZ+
Content-Type: multipart/mixed; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is a fix for full duplex transfer mode on the mpc52xx_psc_spi driver.
Details see the patch header. Tested on a mpc5200b board.

Cheers
Luotao fu
--=20
   Dipl.-Ing. Luotao Fu | Phone: +49-5121-206917-3
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de


--3lcZGd9BuhuYXNfi
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="mpc52xx_psc_spi_fix_block_send.diff"
Content-Transfer-Encoding: quoted-printable

=46rom: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: fix block transfer on mpc52xx psc spi

  The block transfer routine in the mpc52xx psc spi driver misinterpret the
  datasheet. According to the processor datasheet the chipselect is held as
  long as the EOF is not written. Theoretically block of any sizes can be
  transferd in this way. The old routine however writes an EOF after every
  word, which has the size of size_of_word. This makes the transfer slow.
  Also fixed some duplicate code.

Signed-off-by: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

---
 drivers/spi/mpc52xx_psc_spi.c |   22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

Index: drivers/spi/mpc52xx_psc_spi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/spi/mpc52xx_psc_spi.c.orig
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -146,7 +146,6 @@ static int mpc52xx_psc_spi_transfer_rxtx
 	unsigned rfalarm;
 	unsigned send_at_once =3D MPC52xx_PSC_BUFSIZE;
 	unsigned recv_at_once;
-	unsigned bpw =3D mps->bits_per_word / 8;
=20
 	if (!t->tx_buf && !t->rx_buf && t->len)
 		return -EINVAL;
@@ -162,22 +161,15 @@ static int mpc52xx_psc_spi_transfer_rxtx
 		}
=20
 		dev_dbg(&spi->dev, "send %d bytes...\n", send_at_once);
-		if (tx_buf) {
-			for (; send_at_once; sb++, send_at_once--) {
-				/* set EOF flag */
-				if (mps->bits_per_word
-						&& (sb + 1) % bpw =3D=3D 0)
-					out_8(&psc->ircr2, 0x01);
+		for (; send_at_once; sb++, send_at_once--) {
+			/* set EOF flag before the last word is sent */
+			if (send_at_once =3D=3D 1)
+				out_8(&psc->ircr2, 0x01);
+
+			if (tx_buf)
 				out_8(&psc->mpc52xx_psc_buffer_8, tx_buf[sb]);
-			}
-		} else {
-			for (; send_at_once; sb++, send_at_once--) {
-				/* set EOF flag */
-				if (mps->bits_per_word
-						&& ((sb + 1) % bpw) =3D=3D 0)
-					out_8(&psc->ircr2, 0x01);
+			else
 				out_8(&psc->mpc52xx_psc_buffer_8, 0);
-			}
 		}
=20
=20

--3lcZGd9BuhuYXNfi--

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIibxtiruQY+UyUmERAnrnAJ9oG8A0N0/uPe+rL3fv/ELUTnTL6gCeKx8D
i6ERK59IhmvpbVUcK4wDCKA=
=iisq
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--


--===============0113562033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0113562033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0113562033==--
