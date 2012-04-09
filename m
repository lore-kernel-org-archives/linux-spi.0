From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: spi-s3c64xx: problems with SPI_MODE_3 transfers
Date: Mon, 9 Apr 2012 12:21:08 +0530
Message-ID: <CABb+yY3_YAk_V5ZVJ1ntKEhvsL4BcC+YSnu_-6v=dHCMZ6ZmHg@mail.gmail.com>
References: <201204082039.34325.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201204082039.34325.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 9, 2012 at 12:09 AM, Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> [@jassi: I know that you do not work at this stuff any longer, but I =
included
> you in the list of recipients in the hope that you might be able to g=
ive me a
> pointer on where to look for the culprit of the problem :-) ]
>
>
> Hi,
>
> while working on the beginnings of a wireless driver connected via SP=
I [1],
> the s3c64xx-spi-driver produced strange problems while doing MODE_3 =C2=
=A0(CPOL |
> CPHA) transfers: [2]
>
> [write] spi cur_bpw: 8: =C2=A00x00 0x00 0x04 0x00
> [read] =C2=A0spi cur_bpw: 8: =C2=A00x00 0x00 0x00 0x00
> [read] =C2=A0spi cur_bpw: 8: =C2=A00x00 0x00 0x00 0x00
> (chip_id =3D 0x0000, chip_rev =3D 0x00)
> mapped channel 24 to 0
> mapped channel 23 to 1
> [write] spi cur_bpw: 8: =C2=A00x00 0x00 0x04 0x00
> [read] =C2=A0spi cur_bpw: 8: =C2=A00x00 0x00 0x00 0x00
> [read] =C2=A0spi cur_bpw: 8: =C2=A00x00 0x00 0x00 0x00
> CIR: 0
> [write] spi cur_bpw: 8: =C2=A00x00 0x00 0x04 0x00
> [read] =C2=A0spi cur_bpw: 8: =C2=A00x00 0x00 0x00 0x00
> mt592x_spi spi0.0: I/O Error: rx-1 tx-0 res:rx-f tx-p len-4
> CIR: 0
> [write] spi cur_bpw: 8: =C2=A00x00 0x00 0x04 0x00
> mt592x_spi spi0.0: I/O Error: rx-0 tx-1 res:rx-p tx-f len-4
> CIR: 0
> [write] spi cur_bpw: 8: =C2=A00x00 0x00 0x04 0x00
> mt592x_spi spi0.0: I/O Error: rx-0 tx-1 res:rx-p tx-f len-4
> CIR: 0
> [write] spi cur_bpw: 8: =C2=A00x00 0x00 0x04 0x00
> mt592x_spi spi0.0: I/O Error: rx-0 tx-1 res:rx-p tx-f len-4
> CIR: 0
>
> where the expected result would be:
>
> [write] spi cur_bpw: 8: =C2=A00x00 0x00 0x04 0x00
> [read] =C2=A0spi cur_bpw: 8: =C2=A00x00 0x00 0x00 0x00
> [read] =C2=A0spi cur_bpw: 8: =C2=A00x21 0x59 0x91 0x00
>
> The pattern of either empty results or read errors also varies with e=
ach
> invocation, i.e. sometimes all fail or all result in wrong values and=
 so on.
>
>
> In contrast when doing this with the spi-gpio driver, everything work=
s as
> expected and I get the expected results.
>
> Also the device-family I'm working on contains a variant with a Marve=
ll 8686
> wlan chip [=3D the rest of the system is the same]. Using the spi-s3c=
64xx with
> the libertas driver (MODE_0) works as expected.
>
>
> As I'm not sure where I should look for errors in the driver, I would=
 be glad
> to get pointers in the right direction.
>
You might want to play around tuning the 'fb_delay' and maybe signal
strength too.

-j
