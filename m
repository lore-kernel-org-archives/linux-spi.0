From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip select and whitens the GTA04 LCD panel
Date: Tue, 2 Apr 2019 08:37:23 +0200
Message-ID: <F8ACE730-B498-41E2-A486-923C760807F8@goldelico.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com> <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com> <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com> <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com> <CACRpkda4k_Vaoo1qEaZ3nv8bA4tcrPEN6oT-v+n9HRdA6=5Xvg@mail.gmail.com> <2D2D13C2-0D3E-47CD-946B-81DBBF3C43E6@goldelico.com> <20190402053143.GZ2059@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        Wolfgang Ocker <weo@reccoware.de>,
        Jan Kotas <jank@cadence.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402053143.GZ2059@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


> Am 02.04.2019 um 07:31 schrieb Mark Brown <broonie@kernel.org>:
>=20
> It's relatively common, especially with older devices, for people to =
be
> perfectly happy to update the kernel and do so frequently but =
unwilling
> to update the bootloader as the procedure for recovering a broken
> bootloader is difficult or perhaps not even possible.

Yes, that is the case Linus tries to solve, where it is not even =
possible
to modify the DTB. No idea how it could be solved if it would not be
possible to change our 6 years old DTB.

Fortunately we do not need to change it at all with the latest check for
cs-gpios.

>=20
>> This also gives another idea: make it depend on "powerpc".
>=20
> That won't fly, the code has always been architecture neutral.

Ok. Just an idea.

>=20
>>> Dunno about this, it looks fragile, I would prefer to keep all =
working.
>>> But I will listen to reason.
>=20
>> Reason why I propose a CONFIG option is:
>=20
>> if someone is able to compile and deploy a v5.1 kernel for some =
device which
>> has (old) and problematic DTB in ROM he/she must have access to the =
.config.
>> So it is easy to modify it to enable legacy handling of spi-cs-high. =
And keep
>> it disabled for all others.
>=20
> This assumes people aren't able to run a distro kernel...

Yes, indeed.

I have learned from Linus that the problem with legacy spi-cs-high are =
mostly embedded
powerpc systems deployed between 2008 and 2013 where the boot-loader =
can't be
changed. And where the dts is not maintained on kernel.org.

IMHO it is very unlikely that they are running distro kernels. Or is =
there an example
of such a system?

BR and thanks,
Nikolaus
