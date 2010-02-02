From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [GIT PULL] sh updates for 2.6.33-rc7
Date: Tue, 2 Feb 2010 01:31:18 -0700
Message-ID: <fa686aa41002020031r38e6bc9eyfce6476d86d47ec2@mail.gmail.com>
References: <20100202040628.GH13428@linux-sh.org> <fa686aa41002020017m5ea0020di6924905a631dc7d6@mail.gmail.com>
	<20100202082144.GB5716@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Paul Mundt <lethal@linux-sh.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100202082144.GB5716@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 2, 2010 at 1:21 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Feb 02, 2010 at 01:17:49AM -0700, Grant Likely wrote:
>> On Mon, Feb 1, 2010 at 9:06 PM, Paul Mundt <lethal@linux-sh.org> wro=
te:
>> > Please pull from:
>> >
>> > ? ? ? ?master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.g=
it sh/for-2.6.33
>> >
>> > Which contains:
>> >
>> > Magnus Damm (1):
>> > ? ? ?usb: r8a66597-hdc disable interrupts fix
>> >
>> > Marek Skuczynski (2):
>> > ? ? ?sh: Fix access to released memory in dwarf_unwinder_cleanup()
>> > ? ? ?sh: Fix access to released memory in clk_debugfs_register_one=
()
>> >
>> > Markus Pietrek (1):
>> > ? ? ?spi: spi_sh_msiof: Fixed data sampling on the correct edge
>>
>> Hold the phone; please coordinate with me before picking up SPI
>> patches into your tree. =A0I don't mind arch specific spi changes go=
ing
>> in via a different tree, but I'd like to know about it before I wast=
e
>> time farting around with the same patch (like I did with this one
>> tonight, and only found out that you also picked it up when I came
>> across this pull request by chance).
>>
> If there's someone actively looking after the SPI stuff then that's f=
ine.

I am now.  There wasn't anyone for a while.

> I didn't bother bouncing this one off of the SPI list since it's a
> hardware-specific correctness fix and has no dependency on anything
> subsystem related.

=46air enough, but the patch itself came across the SPI list, and so it
showed up in the patchwork tracking of spi-devel-general which I'm
using to keep on top of everything.  I brief reply to the patch email
would have let me know that I didn't have to waste any time with it.

Thanks,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
