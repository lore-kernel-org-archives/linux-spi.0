From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [Patch 0/4] IndustrialIO subsystem (ADCs, accelerometers etc)
Date: Fri, 25 Jul 2008 15:28:04 +0400
Message-ID: <20080725112804.GA7843@polina.dev.rtsoft.ru>
References: <488763AD.4050400@gmail.com> <alpine.LNX.1.10.0807250025080.11551@fbirervta.pbzchgretzou.qr> <4889B524.5010602@gmail.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Jan Engelhardt <jengelh@medozas.de>,
	LKML <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>,
	Dmitry Torokhov <dtor@mail.ru>,
	"Hans J. Koch" <hjk@linutronix.de>, hmh@hmh.eng.br,
	David Brownell <david-b@pacbell.net>, mgross@linux.intel.com,
	Ben Nizette <bn@niasdigital.com>
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755558AbYGYL2V@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4889B524.5010602@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 25, 2008 at 12:12:36PM +0100, Jonathan Cameron wrote:
> Jan Engelhardt wrote:
> > On Wednesday 2008-07-23 19:00, Jonathan Cameron wrote:
> >
> >   
> >> Dear All,
> >>
> >> The need for an industrialio subsystem was discussed in
> >> http://lkml.org/lkml/2008/5/20/135
> >>
> >> Firstly thanks to all the people who have contributed to the discussion
> >> of this in the past.
> >>
> >> In brief the intention is provide a kernel subsystem directed towards the
> >> handling on sensors (and later related output devices) such as ADC's,
> >> accelerometers and many others.
> >>     
> >
> > Could this be done using UIO instead?
> >   
> No, this lot is directed towards devices that use serial buses such as
> i2c  and SPI
[...]

There is spidev driver to do SPI in userspace. But no, it does not mean
that we can always use UIO. For example, we can't use UIO when we want to
process IRQs (think touchscreen pen-down irq), or better, we anyway will
need to write UIO-kernel helper for this.

So, sometimes it's just more convenient to do things in kernel.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
