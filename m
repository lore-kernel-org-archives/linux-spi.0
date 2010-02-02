From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [GIT PULL] sh updates for 2.6.33-rc7
Date: Tue, 2 Feb 2010 01:17:49 -0700
Message-ID: <fa686aa41002020017m5ea0020di6924905a631dc7d6@mail.gmail.com>
References: <20100202040628.GH13428@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Paul Mundt <lethal@linux-sh.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100202040628.GH13428@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 1, 2010 at 9:06 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> Please pull from:
>
> =A0 =A0 =A0 =A0master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-=
2.6.git sh/for-2.6.33
>
> Which contains:
>
> Magnus Damm (1):
> =A0 =A0 =A0usb: r8a66597-hdc disable interrupts fix
>
> Marek Skuczynski (2):
> =A0 =A0 =A0sh: Fix access to released memory in dwarf_unwinder_cleanu=
p()
> =A0 =A0 =A0sh: Fix access to released memory in clk_debugfs_register_=
one()
>
> Markus Pietrek (1):
> =A0 =A0 =A0spi: spi_sh_msiof: Fixed data sampling on the correct edge

Hold the phone; please coordinate with me before picking up SPI
patches into your tree.  I don't mind arch specific spi changes going
in via a different tree, but I'd like to know about it before I waste
time farting around with the same patch (like I did with this one
tonight, and only found out that you also picked it up when I came
across this pull request by chance).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
