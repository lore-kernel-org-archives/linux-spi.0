From: Colin Ian King <colin.king@canonical.com>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver is
 released
Date: Thu, 26 Sep 2019 11:15:33 +0100
Message-ID: <abeb7029-0b24-64f0-0d1c-63f12ba8fffe@canonical.com>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
 <20190926121438.655f1f10@jawa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JK1TJ4HRO8ttDzM3Z5PzE9QI2kMZYmiVZ"
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926121438.655f1f10@jawa>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JK1TJ4HRO8ttDzM3Z5PzE9QI2kMZYmiVZ
Content-Type: multipart/mixed; boundary="pMI8gq1huC3pfVevEOlp2gM57uALqDbuT";
 protected-headers="v1"
From: Colin Ian King <colin.king@canonical.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <abeb7029-0b24-64f0-0d1c-63f12ba8fffe@canonical.com>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver is
 released
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
 <20190926121438.655f1f10@jawa>
In-Reply-To: <20190926121438.655f1f10@jawa>

--pMI8gq1huC3pfVevEOlp2gM57uALqDbuT
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26/09/2019 11:14, Lukasz Majewski wrote:
> Hi Colin,
>=20
>> Hi,
>>
>> Static analysis with Coverity has detected an potential dereference
>> of a free'd object with commit:
>>
>> commit 9f918a728cf86b2757b6a7025e1f46824bfe3155
>> Author: Lukasz Majewski <lukma@denx.de>
>> Date:   Wed Sep 25 11:11:42 2019 +0200
>>
>>     spi: Add call to spi_slave_abort() function when spidev driver is
>> released
>>
>> In spidev_release() in drivers/spi/spidev.c the analysis is as
>> follows:
>>
>> 600static int spidev_release(struct inode *inode, struct file *filp)
>> 601{
>> 602        struct spidev_data      *spidev;
>> 603
>> 604        mutex_lock(&device_list_lock);
>>
>>    1. alias: Assigning: spidev =3D filp->private_data. Now both point =
to
>> the same storage.
>>
>> 605        spidev =3D filp->private_data;
>> 606        filp->private_data =3D NULL;
>> 607
>> 608        /* last close? */
>> 609        spidev->users--;
>>
>>    2. Condition !spidev->users, taking true branch.
>>
>> 610        if (!spidev->users) {
>> 611                int             dofree;
>> 612
>> 613                kfree(spidev->tx_buffer);
>> 614                spidev->tx_buffer =3D NULL;
>> 615
>> 616                kfree(spidev->rx_buffer);
>> 617                spidev->rx_buffer =3D NULL;
>> 618
>> 619                spin_lock_irq(&spidev->spi_lock);
>>
>>    3. Condition spidev->spi, taking false branch.
>>
>> 620                if (spidev->spi)
>> 621                        spidev->speed_hz =3D
>> spidev->spi->max_speed_hz; 622
>> 623                /* ... after we unbound from the underlying
>> device? */
>>
>>    4. Condition spidev->spi =3D=3D NULL, taking true branch.
>>
>> 624                dofree =3D (spidev->spi =3D=3D NULL);
>> 625                spin_unlock_irq(&spidev->spi_lock);
>> 626
>>
>>    5. Condition dofree, taking true branch.
>>
>> 627                if (dofree)
>>
>>    6. freed_arg: kfree frees spidev.
>>
>> 628                        kfree(spidev);
>> 629        }
>> 630#ifdef CONFIG_SPI_SLAVE
>>
>>    CID 89726 (#1 of 1): Read from pointer after free (USE_AFTER_FREE)
>> 7. deref_after_free: Dereferencing freed pointer spidev.
>>
>> 631        spi_slave_abort(spidev->spi);
>> 632#endif
>> 633        mutex_unlock(&device_list_lock);
>> 634
>> 635        return 0;
>> 636}
>>
>> The call to spi_slave_abort() on spidev is reading an earlier kfree'd
>> spidev.
>=20
> Thanks for spotting this issue - indeed there is a possibility to use
> spidev after being kfree'd.=20
>=20
> However, Geert (CC'ed) had some questions about placement of this
> function call, so I will wait with providing fix until he replies.

Cool, thanks for the update.

Colin
>=20
>>
>> Colin
>>
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.d=
e
>=20



--pMI8gq1huC3pfVevEOlp2gM57uALqDbuT--

--JK1TJ4HRO8ttDzM3Z5PzE9QI2kMZYmiVZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcGLapPABucZhZwDPaMKH38aoAiYFAl2Mj8YACgkQaMKH38ao
AiYYLQ/+OP0GMNizJhdTJA+4gXUyJ0geSuq8uk0MmMVw2p3p3Ty0oQsVH52qkpiV
U2YY8uLxHDeu9aXudMEp6VsbS5y7J9V2Uv1JQjjJt0fZ794SEfTKx2cgP59eD/IN
BIKPYOq0+pBD+7whivvvdqOZGwK48//Omst2Y0dBKMGcCQ1mUzp8aGUBl304b0PV
mt4Vz35B925LW1ah+I/1Rb7zXL9oq6/0NUGgCTX2UGaOALQ2f3cFlpfwdz4GHJ/f
4EkhDIcSzcgWyoaS310B0nekng2Xw7iF4ae1WhpqejbbY1SCr5k4IIm/lkAK7e2j
+soLc02QyHIHlfDK+sYUmQuK/zX0oAYPtqUI6WSO0inh6gKURHvMnHKCT2dwFNGJ
bqoSCt0xwRxGtL8KsPHVApXQ7U/hQ5TDj7UxzLsx2l0kNhPxEijPdHyqQ9vcFtAK
CV5GiDYfpyhycNnOlc205i1DbANK+9ZlZDaTVGMUxckDYCid82JRggI2FT7SHpYC
uf8H1jFA9Y3adMtjRSELzMow5hMd3JHzUK8AZzvqOg4RuWjI2DeJOr+ScDseB3pN
eRBsIS19Z//tsSHU1X1KqfPql7gMB+g70yI6C2T4x7RQL0k3Zv3G3j2QgspO+Tkj
P0vwEi9PpjVMMMYZhbT8YJR6RT70asIgvItwig0IniWRBtYwnXA=
=whl9
-----END PGP SIGNATURE-----

--JK1TJ4HRO8ttDzM3Z5PzE9QI2kMZYmiVZ--
