From: Lukasz Majewski <lukma@denx.de>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver
 is released
Date: Thu, 26 Sep 2019 12:14:38 +0200
Message-ID: <20190926121438.655f1f10@jawa>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X=HjYTciBWNPBESkWNyLgtO"; protocol="application/pgp-signature"
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/X=HjYTciBWNPBESkWNyLgtO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Colin,

> Hi,
>=20
> Static analysis with Coverity has detected an potential dereference
> of a free'd object with commit:
>=20
> commit 9f918a728cf86b2757b6a7025e1f46824bfe3155
> Author: Lukasz Majewski <lukma@denx.de>
> Date:   Wed Sep 25 11:11:42 2019 +0200
>=20
>     spi: Add call to spi_slave_abort() function when spidev driver is
> released
>=20
> In spidev_release() in drivers/spi/spidev.c the analysis is as
> follows:
>=20
> 600static int spidev_release(struct inode *inode, struct file *filp)
> 601{
> 602        struct spidev_data      *spidev;
> 603
> 604        mutex_lock(&device_list_lock);
>=20
>    1. alias: Assigning: spidev =3D filp->private_data. Now both point to
> the same storage.
>=20
> 605        spidev =3D filp->private_data;
> 606        filp->private_data =3D NULL;
> 607
> 608        /* last close? */
> 609        spidev->users--;
>=20
>    2. Condition !spidev->users, taking true branch.
>=20
> 610        if (!spidev->users) {
> 611                int             dofree;
> 612
> 613                kfree(spidev->tx_buffer);
> 614                spidev->tx_buffer =3D NULL;
> 615
> 616                kfree(spidev->rx_buffer);
> 617                spidev->rx_buffer =3D NULL;
> 618
> 619                spin_lock_irq(&spidev->spi_lock);
>=20
>    3. Condition spidev->spi, taking false branch.
>=20
> 620                if (spidev->spi)
> 621                        spidev->speed_hz =3D
> spidev->spi->max_speed_hz; 622
> 623                /* ... after we unbound from the underlying
> device? */
>=20
>    4. Condition spidev->spi =3D=3D NULL, taking true branch.
>=20
> 624                dofree =3D (spidev->spi =3D=3D NULL);
> 625                spin_unlock_irq(&spidev->spi_lock);
> 626
>=20
>    5. Condition dofree, taking true branch.
>=20
> 627                if (dofree)
>=20
>    6. freed_arg: kfree frees spidev.
>=20
> 628                        kfree(spidev);
> 629        }
> 630#ifdef CONFIG_SPI_SLAVE
>=20
>    CID 89726 (#1 of 1): Read from pointer after free (USE_AFTER_FREE)
> 7. deref_after_free: Dereferencing freed pointer spidev.
>=20
> 631        spi_slave_abort(spidev->spi);
> 632#endif
> 633        mutex_unlock(&device_list_lock);
> 634
> 635        return 0;
> 636}
>=20
> The call to spi_slave_abort() on spidev is reading an earlier kfree'd
> spidev.

Thanks for spotting this issue - indeed there is a possibility to use
spidev after being kfree'd.=20

However, Geert (CC'ed) had some questions about placement of this
function call, so I will wait with providing fix until he replies.

>=20
> Colin
>=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/X=HjYTciBWNPBESkWNyLgtO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2Mj44ACgkQAR8vZIA0
zr2RVAf/RsM6loK8yXKEEfi1JBemrB194ucZYBOo+tmulnC7ev/KXq/BD8yWMjoj
9UqkU8imI1AWUtOs87oti6OV0vxW818mEG/jEahTnpOgOOj7K7yhWZfGQvCHQtTs
iFm5gubARdK+68E9iPd7TNA1q/fYwg5WRl9PyDFJL9jliTLfi3XK5NyTENbQ3buW
qEEj2M6VOoj+AONMMwoRJX9t/xOzkMW+Mxv/SD7ulJPF9M8ABTPxsQ8wyJsDMKvx
kZJry+6sl7jbHHPYrVFW6snT+RXhsg++NsWJy4dUq7TMc9baaFyvnDTZD0Owok6v
KJKLNCjZp1bH8WkrnHyo9yfSVH8Czg==
=8gl2
-----END PGP SIGNATURE-----

--Sig_/X=HjYTciBWNPBESkWNyLgtO--
