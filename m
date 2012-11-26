From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 3.7] spi/bcm63xx: fix transfer bits_per_words check
Date: Mon, 26 Nov 2012 14:11:20 +0100
Message-ID: <2175243.jGVtISFVra@flexo>
References: <1353764690-5961-1-git-send-email-jonas.gorski@gmail.com> <20121124180151.GJ4719@opensource.wolfsonmicro.com> <CAOiHx=nXRgF6YCLJ+U77boeuuWb6TOdT9dg=cie=Gruz6eS6xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	Maxime Bizon <mbizon@freebox.fr>,
	Kevin Cernekee <cernekee@gmail.com>, stable@vger.kernel.org
To: Jonas Gorski <jonas.gorski@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAOiHx=nXRgF6YCLJ+U77boeuuWb6TOdT9dg=cie=Gruz6eS6xQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Saturday 24 November 2012 19:19:34 Jonas Gorski wrote:
> On 24 November 2012 19:01, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Sat, Nov 24, 2012 at 06:53:10PM +0100, Jonas Gorski wrote:
> >> On 24 November 2012 18:28, Mark Brown
> >
> >> > This is now done by the SPI core, there's no need for individual drivers
> >> > to do this.
> >
> >> So that will go to stable kernels, too?
> >
> > No, I hadn't sent it there.  I'd really expect that anyone using a
> > release kernel would've noticed this if there were a problem, it's
> > pretty obvious when it goes wrong, and I tend to be extremely
> > conservative with changes to stable kernels especially framework ones.
> 
> Well, I noticed this particular problem on a 3.6 kernel (3.6.7 to be
> exact), so by that definition at least one noticed, unless I don't
> count as anyone ;-). So, how can I make this driver less broken for
> release kernels? I somewhat doubt the framework change will be picked
> up by release kernel maintainers.

Considering it is a simple one-liner in spi-bcm63xx and that you don't want to
propagate a framework-level change back to -stable (which makes sense), don't
you want to pick that one?

At least two other users told me about this bug in private conversations.
--
Florian
