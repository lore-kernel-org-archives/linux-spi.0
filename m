From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] Documentation: dt: mtd: replace "nor-jedec" binding with "jedec,spi-nor"
Date: Tue, 19 May 2015 09:27:50 +0200
Message-ID: <CACna6rzpxoXEJbeRyxaR0wiPpWc_MmgvnqoW-dSw4fF-=EMM_g@mail.gmail.com>
References: <1431624773-4165-1-git-send-email-computersforpeace@gmail.com>
	<20150515195541.GL11598@ld-irv-0074>
	<20150518104501.GD3551@leverpostej>
	<20150518183442.GR11598@ld-irv-0074>
	<CAMuHMdUCj2AXk_0mAgRfAStrveHPi=Rp2g-b177zO_ode8NaCw@mail.gmail.com>
	<20150519013415.GV11598@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Marek Vasut <marex@denx.de>,
	linux-spi <linux-spi@vger.kernel.org>
To: Brian Norris <computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150519013415.GV11598@ld-irv-0074>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 19 May 2015 at 03:34, Brian Norris <computersforpeace@gmail.com> wrote:
> So how about the following patch? It seems like we'll need to be able to
> ignore useless 'modalias' values in cases like this:
>
>         // modalias = "shinynewdevice"
>         compatible = "myvendor,shinynewdevice", "jedec,spi-nor";
>
> and also if somebody leaves off the entire shinynewdevice string:
>
>         // modalias = "spi-nor"
>         compatible = "jedec,spi-nor";
>
> So we rework the spi-nor library to not reject "bad" names, and just
> fall back to autodetection, and we add the .of_match_table to properly
> catch all "jedec,spi-nor".

That's nice but what about platforms using platform data instead of
DT? I would like to use some kind of "spi-nor" (with some prefix
*maybe*) for them too.
