From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] [drivers] [SPI] SPI_GPIO: add support for controllers without MISO or MOSI pin
Date: Tue, 30 Jun 2009 18:39:13 -0700
Message-ID: <200906301839.13764.david-b@pacbell.net>
References: <000a01c9f61f$fd7ff3d0$f87fdb70$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net, kyungmin.park@samsung.com
To: Marek Szyprowski <m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756173AbZGABjo@vger.kernel.org>
In-Reply-To: <000a01c9f61f$fd7ff3d0$f87fdb70$%szyprowski@samsung.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday 25 June 2009, Marek Szyprowski wrote:
> --- a/drivers/spi/spi_bitbang.c
> +++ b/drivers/spi/spi_bitbang.c
> @@ -392,6 +392,22 @@ int spi_bitbang_transfer(struct spi_device *spi,=
 struct spi_message *m)
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned long=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
flags;
> =A0=A0=A0=A0=A0=A0=A0=A0int=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0status =3D 0;
> =A0
> +=A0=A0=A0=A0=A0=A0=A0if (spi->master->flags & SPI_MASTER_NO_RX) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct spi_transfer *xf=
er;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0list_for_each_entry(xfe=
r, &m->transfers, transfer_list) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
if (xfer->rx_buf)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0}

Actually these two loops should merge, and likely move with
spi_async() into the spi.c core code ... I'll split this
support into a separate patch.

> +
> +=A0=A0=A0=A0=A0=A0=A0if (spi->master->flags & SPI_MASTER_NO_TX) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct spi_transfer *xf=
er;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0list_for_each_entry(xfe=
r, &m->transfers, transfer_list) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
if (xfer->tx_buf)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> =A0=A0=A0=A0=A0=A0=A0=A0m->actual_length =3D 0;
> =A0=A0=A0=A0=A0=A0=A0=A0m->status =3D -EINPROGRESS;
> =A0
