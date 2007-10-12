From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 02/10] Blackfin SPI driver: use new GPIO API and add error handling
Date: Thu, 11 Oct 2007 23:26:34 -0700
Message-ID: <200710112326.34500.david-b@pacbell.net>
References: <1192158304-8277-1-git-send-email-bryan.wu@analog.com> <1192158304-8277-3-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	Michael Hennerich <michael.hennerich@analog.com>
To: Bryan Wu <bryan.wu@analog.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759938AbXJLG0r@vger.kernel.org>
In-Reply-To: <1192158304-8277-3-git-send-email-bryan.wu@analog.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday 11 October 2007, Bryan Wu wrote:
> @@ -1182,12 +1198,9 @@ static int __init bfin5xx_spi_probe(struct pla=
tform_device *pdev)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0
> -=A0=A0=A0=A0=A0=A0=A0if (peripheral_request(P_SPI0_SCK, DRV_NAME) ||
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 peripheral_request(P_S=
PI0_MISO, DRV_NAME) ||
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 peripheral_request(P_S=
PI0_MOSI, DRV_NAME) ) {
> -
> +=A0=A0=A0=A0=A0=A0=A0if (setup_pin_mux(1)) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_err(&pdev->dev, "=
: Requesting Peripherals failed\n");
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out_error_queue_al=
loc;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out_error;
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0drv_data =3D spi_master_get_devdata(master);
>=20

Still doesn't apply ... what tree are you generating this series agains=
t??
