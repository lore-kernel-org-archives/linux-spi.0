From: NeilBrown <neil@brown.name>
Subject: Re: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
Date: Wed, 13 Jun 2018 08:24:26 +1000
Message-ID: <87sh5riqxx.fsf@notabene.neil.brown.name>
References: <1528708694-19407-1-git-send-email-yogeshnarayan.gaur@nxp.com> <20180611114916.351ed272@bbrezillon> <87r2ldj7xi.fsf@notabene.neil.brown.name> <20180612092248.4e6a3e92@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        linux-mtd@lists.infradead.org, boris.brezillon@free-electrons.com,
        frieder.schrempf@exceet.de, computersforpeace@gmail.com,
        david.wolfe@nxp.com, han.xu@nxp.com, festevam@gmail.com,
        marek.vasut@gmail.com, prabhakar.kushwaha@nxp.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612092248.4e6a3e92@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Jun 12 2018, Boris Brezillon wrote:

>
> Just because you managed to solve the problem in one driver does not
> mean the problem does not exist for others. I read this datasheet [1]
> several times and couldn't find a way to say 'I want to keep the CS
> asserted between 2 transactions', so I think we really need this patch.

I agree that my experience doesn't necessarily generalize.  As the patch
carried by signed-off-by (even though I only wrote little parts of it) I
wanted to make it clear that I had no desire to promote the patch -
maybe I stated that too strongly.

Thanks for the link to the data sheet.  I had a bit of a look, but
reading these things must be an art that I haven't fully mastered yet -
it would probably take me a few days to really understand it.
The Programmable Sequence Enginine (Section 10.2.5.3.1) seems
interesting. I wouldn't be surprised that that lets you do interesting
things.

It is obviously quite a powerful unit and it is surprising - to me -
that it might not allow arbitrarily long messages, but I cannot justify
the time to really dig in and see if that is the case.
Maybe you are right.  I have no particular objections to the patch, I
just don't want to be seen as speaking in favour of it.

Thanks,
NeilBrown


>
> Regards,
>
> Boris
>
> [1]https://www.nxp.com/docs/en/reference-manual/VFXXXRM.pdf

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsgSBoACgkQOeye3VZi
gbmEQQ/9EtAAeJYjXQHQOr4P79+wEAposchwmDGzy1RDb3R6MFeLzl8CYyCpg/ma
ll6hRREuJ7IcLE+4weGyeNadGxTBGUFpJ87srm46QmzeJxZKv8PcJxILgfAABtet
uI7Ru4dFpDyIGOhgzjsKtp40093RIqxlY7j4fRMQAziaAHASw/bJmz/NwZgbeQol
/tlKcLKub2n0p2vxiDvj6DcTkMcPRElTmQw5OUQpn2kW5sSMUxg61yilXZHX9tq9
6iuC+vJ1AywX0aXovivq+y72wk9/qjg1SnhjyRZWAYhPxpoWf9lLlRUjVK9ZjnfU
dZr+TLQm897qLKXv0FLXUBoArrxFL5K1znLphNdqKzoeXuL80Z9qt7VDHEPzcaVR
yvTTx8AszModPzqeMCzCijsjCRyfVIg2FfB/ap0ma70Po9GQ3+lkNWHgwlI99+Nz
IdGXYseRPAwgwmHgpGC89Mlw6sly8ryPzwwajHEg5qTem4ZW+emKehrGlanzgr89
3onaYEYc9tgp1+Ksj/j4Zb9OwgyE+Lzt7e4JilRmZKRHS/eXNQoWAS/ODGFI5cJf
6aJsTI4/08aKzHLApjZDck5fDKlT48+PNu6ADQqWsWw6Yi307mNlDgg8jOPRvUhi
SI3r2L9QCwA7YPAIDA3WGAwaMRvSeVz5zJ5eX+s4+NvWcU7+jfg=
=19Jr
-----END PGP SIGNATURE-----
--=-=-=--
