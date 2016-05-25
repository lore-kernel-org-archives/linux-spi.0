From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v3 00/12] J-core J2 cpu and SoC peripherals support
Date: Wed, 25 May 2016 18:24:41 -0400
Message-ID: <20160525222441.GS21636@brightrain.aerifal.cx>
References: <cover.1464148904.git.dalias@libc.org>
 <20160525095444.GR8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160525095444.GR8206@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 25, 2016 at 10:54:44AM +0100, Mark Brown wrote:
> On Wed, May 25, 2016 at 05:43:02AM +0000, Rich Felker wrote:
> 
> > As arch/sh co-maintainer my intent is to include as much as possible
> > in my pull request for the linux-sh tree. If there are parts outside
> > of arch/sh that can be included in this, please let me know. I'm not
> 
> Do *not* include the SPI driver, you shouldn't be including any drivers
> unless it's been explicitly discussed with the subsystem maintainers.

See the "please let me know". I thought this was plenty clear that I
was asking for permission for including things outside of arch/sh, and
that short of getting an ack, the default permission is no. You also
snipped the part of my message that mentioned the specific subsystems
I was asking about (which were non-SPI because you already made quite
a point about not taking the SPI driver):

> > clear yet on what the right path to upstream is for the clocksource
> > and irq drivers that are currently only useful/interesting for one
> > arch, or for the DT binding patches. Even if some drivers are delayed
> > [...]

> Quite aside from the fact that like Geert says drivers are expected to
> go through the subsystem trees to repeat what I said last time it wasn't
> posted until after the merge window and we're now a few days before the
> end of the merge window and a new version is being posted.  The
> turnaround times you are demanding on review are unreasonable - people
> get busy, have holidays and so on - and you really need to pay attention
> to what people are telling you about the process or you're just going to
> annoy people.

If you can't review and ack the code on short notice, that's fine;
just say so. There's no need to be overerly hostile about it. I've
gotten arch/sh patches during the merge window before and I try to be
polite with the contributor and ask if there's something seriously
broken that would be improved by my making an effort to check it at
the last minute, or it if can happily wait until next time.

Being that the driver in question here is for a new platform that was
not previously supported upstream and has zero chance of breaking
anything else, and that its inclusion would be a big plus for users of
the platform, I don't see any reason for you making such a big deal
out of it unless enforcing policy for its own sake makes you feel
good, but I have better things to do than argue about it.

> > arch, or for the DT binding patches. Even if some drivers are delayed
> > going upstream, I would really like to get DT bindings acked and
> > ideally merged, because we want to go ahead with moving the DTB into
> > J2 boot rom where it belongs, and that should only happen with stable
> 
> If you want people to review DT bindings you're going to need to submit
> them.

I have, twice now, and I Cc'd the the linux-spi list too on v3 for the
spi binding. Rob Herring acked it.

Rich
