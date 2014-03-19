From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] v1 ARM: sun4i: spi: Allow Rx transfers
 larger than FIFO size
Date: Wed, 19 Mar 2014 17:55:07 +0100
Message-ID: <20140319165507.GJ27873@lukather>
References: <2167943.Zs1zPAMITN@nukelap.gtech>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kRoubgraN86rDphl"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBFU2U6MQKGQEXFQ6FSA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2167943.Zs1zPAMITN-joXr/IIKmbNbKQuZ0yLBSw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--kRoubgraN86rDphl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for working on this.

I have a few general comments first:
  - Use a decent mailer for your patches. git send-email is perfect
    for that, use it. Otherwise, your patches will be wrapped, like it
    happened here, and they won't be applyable anymore.
  - The vX should be between the brackets, together with
    PATCH. Remember that everything that is not between these brackets
    will be part of the commit message, and you don't want the version
    number in there.. Either git format-patch or git send-email will
    once again do the right thing if you use the -v or --reroll-count
    option.
  - Those two patches should be merged together. They're doing an
    useful thing, but are pretty much useless one without another, and
    it will avoid adding code just to remove it in the following
    patch.

On Tue, Mar 18, 2014 at 05:04:19PM -0500, Alexandru Gagniuc wrote:
> SPI transfers were limited to one FIFO depth, which is 64 bytes.
> This was an artificial limitation, however, as the hardware can handle
> much larger bursts. To accommodate this, we enable the interrupt when
> the Rx FIFO is 3/4 full, and drain the FIFO within the interrupt
> handler. The 3/4 ratio was chosen arbitrarily, with the intention to
> reduce the potential number of interrupts.
>=20
> Since the SUN4I_CTL_TP bit is set, the hardware will pause
> transmission whenever the FIFO is full, so there is no risk of losing
> data if we can't service the interrupt in time.
>=20
> This patch only handles long Rx transfers, and continues to return
> -EINVAL on long Tx transfers. Tx transfers are handled in a subsequent
> patch.
>=20
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-sun4i.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 3f82705..09d4b54 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -47,6 +47,7 @@
>  #define SUN4I_CTL_TP				BIT(18)
> =20
>  #define SUN4I_INT_CTL_REG		0x0c
> +#define SUN4I_INT_CTL_RF_F34			BIT(4)
>  #define SUN4I_INT_CTL_TC			BIT(16)
> =20
>  #define SUN4I_INT_STA_REG		0x10
> @@ -68,6 +69,8 @@
>  #define SUN4I_XMIT_CNT_REG		0x24
>  #define SUN4I_XMIT_CNT(cnt)			((cnt) & 0xffffff)
> =20
> +#define SUN4I_MAX_XFER_SIZE			0xffffff
> +
>  #define SUN4I_FIFO_STA_REG		0x28
>  #define SUN4I_FIFO_STA_RF_CNT_MASK		0x7f
>  #define SUN4I_FIFO_STA_RF_CNT_BITS		0
> @@ -175,8 +178,11 @@ static int sun4i_spi_transfer_one(struct spi_master=
=20
> *master,
>  	int ret =3D 0;
>  	u32 reg;
> =20
> -	/* We don't support transfer larger than the FIFO */
> -	if (tfr->len > SUN4I_FIFO_DEPTH)
> +	if (tfr->len > SUN4I_MAX_XFER_SIZE)
> +		return -EINVAL;

Why do you still need this test?

> +	/* We only support read transfers larger than the FIFO */
> +	if ((tfr->len > SUN4I_FIFO_DEPTH) && tfr->tx_buf)
>  		return -EINVAL;
> =20
>  	reinit_completion(&sspi->done);
> @@ -274,7 +280,8 @@ static int sun4i_spi_transfer_one(struct spi_master=
=20
> *master,
>  	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
> =20
>  	/* Enable the interrupts */
> -	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
> +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
> +						 SUN4I_INT_CTL_RF_F34);
> =20
>  	/* Start the transfer */
>  	reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
> @@ -287,7 +294,7 @@ static int sun4i_spi_transfer_one(struct spi_master=
=20
> *master,
>  		goto out;
>  	}
> =20
> -	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	/* FIFO is drained during the interrupt handler */

Then don't mention it.

>  out:
>  	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
> @@ -303,10 +310,19 @@ static irqreturn_t sun4i_spi_handler(int irq, void=
=20
> *dev_id)
>  	/* Transfer complete */
>  	if (status & SUN4I_INT_CTL_TC) {
>  		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TC);
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>  		complete(&sspi->done);
>  		return IRQ_HANDLED;
>  	}
> =20
> +	/* Receive FIFO 3/4 full */
> +	if (status & SUN4I_INT_CTL_RF_F34) {
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +		/* Only clear the interrupt _after_ draining the FIFO */
> +		sun4i_spi_write(sspi, SUN4I_INT_STA_REG,=20
> SUN4I_INT_CTL_RF_F34);

Not that it's important, but it really doesn't matter to do it before
or after, the interrupts are disabled in the handler.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--kRoubgraN86rDphl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTKcvrAAoJEBx+YmzsjxAgKOsP/jwZMFtnfmPVrlxoeYF639Uz
eG+kEXnlPv79anecOMUMotjp362XYkFwK2dq3yv2N/fe4Tiz0+Xshb/4ZuFxBHWA
eWcxDE3DOHqT1gv+qR2AhSCHMOzmtvCra3XGrgeoLdkepPzQ3XCRnVKjZ+0Fuqg3
KBufl0wnkr+PvGpfK0M1K05YgWtSmEdVdkw5G1LBjmKtJJlaYubRNVRnt0BTw8Uf
zL1r64MvIGYyHT+Jwrfm7la0+RRzB64lcI2SrEoArP2iDRt0W9OOaagdoYN6RUsL
8Rh+pAhfL+snPHmDGrZucfJdbZP0rfloBoyuv2KVoGXdR1pQSRXMcPEy4/3ycIfn
URWmMRwnJ5UeXK4a1+J/M2NWX+YIIsFzVyS14SCbxTWv+wUtw1lhTJ/gCZrpiHxe
EYqR6xh0S4/Bq+I2sUNQArkD7R15zaXMMbAb+qV3RY8eAPqg2Fcsz7PeO7A5C6IJ
+TGCevN5SHDDbUjsgweJ1GTnfdCRRDugyRZkN3caa9ap/hMFwRGTZMT6+CWpU7Dk
uzFOWLcXb85EJwlmqGyaBMYI43MrOqZIA5zA06wrvJv5zGdnhBZ74hSiuHPwMb1V
EG16HlUXEX1oWU4u/RJN5T1GiqJt01ErNSkyUatrAVGGc/6XOSWRUdoBTAemi7UI
qE6V0ha/63lMcgRvmkKb
=w9eL
-----END PGP SIGNATURE-----

--kRoubgraN86rDphl--
