From: Arnaud Patard (Rtp) <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO Controllers
Date: Thu, 05 Jul 2012 12:38:51 +0200
Message-ID: <87liiyijb8.fsf@lebrac.rtp-net.org>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
	<1341325365-21393-2-git-send-email-andrew@lunn.ch>
	<20120705110251.596331e0@skate> <20120705094824.GO17534@lunn.ch>
	<87sjd6ikkj.fsf@lebrac.rtp-net.org> <20120705122050.2fbc2fe3@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120705122050.2fbc2fe3@skate> (Thomas Petazzoni's message of
	"Thu, 5 Jul 2012 12:20:50 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> writes:

> Le Thu, 05 Jul 2012 12:11:40 +0200,
> Arnaud Patard (Rtp) <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org> a =C3=A9crit :
>
>> > You are not the only one working in this area. Arnaud Patard said =
he
>> > was look at this as well.=20
>>=20
>> yeah, but tbh I've not made anything yet. If Thomas has already some
>> code for it, we should try to make it "generic" so as to use it on
>> armada xp and orion platforms.
>
> The MPP registers are identical on Armada XP/370 and 88F6281 (not sur=
e
> which other SoC datasheet I should be checking). Basically, it's just=
 a
> range of contiguous registers, with 4 bits per pin to select the
> function.


iirc, other SoCs are similar. The small exception being dove I
guess. Dove has a 3rd gpo [the gpios are output only] bank but to be
used as gpio require that a special bit is set and it's for all gpios o=
f
this bank. You'll find this bit in the "general mpp configuration
register" if you look at the datasheet.

>
> So my pinmux driver should simply work as is for Orion as well. The
> only difference between platforms is the number of MPP pins that are
> available, but this number also varies between versions of Armada XP
> and Armada 370, so I already support this in the driver.
>

Are there some output-only gpio on armada xp/370 like on kirkwood/dove =
?


Arnaud
