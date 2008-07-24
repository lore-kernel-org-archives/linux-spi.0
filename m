From: "Hans J. Koch" <hjk@linutronix.de>
Subject: Re: [spi-devel-general] [Patch 0/4] IndustrialIO subsystem (ADCs,
	accelerometers etc)
Date: Thu, 24 Jul 2008 17:38:17 +0200
Message-ID: <20080724153816.GE2254@local>
References: <488763AD.4050400@gmail.com> <20080723191918.GC26938@trinity.fluff.org> <20080724074124.GB2254@local> <20080724100144.GA8301@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Hans J. Koch" <hjk@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@gmail.com>,
	mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>,
	LKML <linux-kernel@vger.kernel.org>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	David Brownell <david-b@pacbell.net>, hmh@hmh.eng.br,
	Jean Delvare <khali@linux-fr.org>,
	spi-devel-general@lists.sourceforge.net,
	Ben Nizette <bn@niasdigital.com>
To: Ben Dooks <ben-linux@fluff.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755794AbYGXPlV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080724100144.GA8301@fluff.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 24, 2008 at 11:01:44AM +0100, Ben Dooks wrote:
> On Thu, Jul 24, 2008 at 09:41:25AM +0200, Hans J. Koch wrote:
> > On Wed, Jul 23, 2008 at 08:19:18PM +0100, Ben Dooks wrote:
> > > On Wed, Jul 23, 2008 at 06:00:29PM +0100, Jonathan Cameron wrote:
> > > > Dear All,
> > > > 
> > > > The need for an industrialio subsystem was discussed in
> > > > http://lkml.org/lkml/2008/5/20/135
> > > 
> > > The name is really bad, this sounds like something for doing large
> > > scale industrial process control.
> > 
> > Well, it says "Industrial I/O". To me, this means it handles I/O devices
> > typically found in industrial applications.
> 
> Yes, industrial is generally process control of manufacturing
> processes which in my view is making this sound like it is limiting
> the field of operations.

OK, I agree.

> 
> All the applications we would currently need are things like
> handheld PDA type devices which are hardly 'industrial' or small
> consumer measurement systems.

Well, though the _use_ of such devices might not be "industrial",
_technically_ they are very similar to embedded systems found in
automation or other industrial equipment.

Many of these devices (all that have mmappable memory) can be handled
with a UIO driver, but for the rest (mostly stuff connected to serial
busses), it's important to have a subsystem in the kernel. I really
don't care too much about its name. BTW, before UIO was first published,
its internal name was "Industrial I/O" ;-)

Thanks,
Hans
