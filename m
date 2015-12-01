From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH resubmit 2/2] spi: fsl-espi: make use of max_msg_size in
 spi_master to handle HW restrictions
Date: Tue, 1 Dec 2015 19:53:56 +0100
Message-ID: <565DECC4.2030507@gmail.com>
References: <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
 <20151119171538.GO31303@sirena.org.uk>
 <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org>
 <20151120120502.GT31303@sirena.org.uk>
 <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org>
 <20151121134946.GI26072@sirena.org.uk> <56507B3B.4080608@gmail.com>
 <CAOMqctR=UDEPbgJDY3YvxpbVEEp4t6ajkyv=cVAZp2fLBNBanA@mail.gmail.com>
 <565CB0C0.9060104@gmail.com> <20151201141923.GJ1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151201141923.GJ1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 01.12.2015 um 15:19 schrieb Mark Brown:
> On Mon, Nov 30, 2015 at 09:25:36PM +0100, Heiner Kallweit wrote:
>> Propagate the 64K message size limitation allowing client drivers
>> to deal properly with this limitation.
>=20
> Please don't submit patches into the middle of existing threads, it
> makes it very confusing trying to work out what the currently propose=
d
> patches are:
>=20
>    8592 N T 11/22 Heiner Kallweit (2.1K) =E2=94=82                   =
=E2=94=82 =E2=94=9C=E2=94=80>[PATCH 2/3] mt
>    8593 N C 11/22 Michal Suchanek (0.5K) =E2=94=82                   =
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80>
> -> 8594 N T 11/22 Heiner Kallweit (0.9K) =E2=94=82                   =
=E2=94=82 =E2=94=9C=E2=94=80>[PATCH 3/3] sp
>    8595 N T 11/30 Heiner Kallweit (1.7K) =E2=94=82                   =
=E2=94=82 =E2=94=9C=E2=94=80>[PATCH v2 1/2]
>    8596 N T 11/30 Heiner Kallweit (0.9K) =E2=94=82                   =
=E2=94=82 =E2=94=94=E2=94=80>[PATCH resubmi
>    8597 NsF 11/22 To Heiner Kallw (1.4K) =E2=94=82                   =
=E2=94=94=E2=94=80>Re: RfC: Handle
>=20
> I *think* the two messages from yesterday are supposed to be a single
> patch series but they're buried in the middle of a huge thread at the
> same level as some older patches and for soem reason have different t=
ags
> (one of which is "resubmit" which is really just adding noise).
>=20
Sorry, my mail template referred to the discussion thread.
I'll resubmit.



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
