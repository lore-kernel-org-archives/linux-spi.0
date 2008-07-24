From: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Subject: Re: [spi-devel-general] [Patch 0/4] IndustrialIO subsystem (ADCs,
 accelerometers etc)
Date: Thu, 24 Jul 2008 17:11:31 +0100
Message-ID: <4888A9B3.8070004@gmail.com>
References: <488763AD.4050400@gmail.com> <20080723191918.GC26938@trinity.fluff.org> <20080724074124.GB2254@local> <20080724100144.GA8301@fluff.org.uk> <20080724153816.GE2254@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-linux@fluff.org>, mgross@linux.intel.com,
	Dmitry Torokhov <dtor@mail.ru>,
	LKML <linux-kernel@vger.kernel.org>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	David Brownell <david-b@pacbell.net>, hmh@hmh.eng.br,
	Jean Delvare <khali@linux-fr.org>,
	spi-devel-general@lists.sourceforge.net,
	Ben Nizette <bn@niasdigital.com>
To: "Hans J. Koch" <hjk@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754073AbYGXQLh@vger.kernel.org>
In-Reply-To: <20080724153816.GE2254@local>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


>>> Well, it says "Industrial I/O". To me, this means it handles I/O devices
>>> typically found in industrial applications.
>>>       
>> Yes, industrial is generally process control of manufacturing
>> processes which in my view is making this sound like it is limiting
>> the field of operations.
>>     
> OK, I agree.
>   
Agreed, though don't yet have a better idea.
In fact my use cases are all really embedded systems anyway.
>> All the applications we would currently need are things like
>> handheld PDA type devices which are hardly 'industrial' or small
>> consumer measurement systems.
>>     
>
> Well, though the _use_ of such devices might not be "industrial",
> _technically_ they are very similar to embedded systems found in
> automation or other industrial equipment.
>
> Many of these devices (all that have mmappable memory) can be handled
> with a UIO driver, but for the rest (mostly stuff connected to serial
> busses), it's important to have a subsystem in the kernel. I really
> don't care too much about its name. BTW, before UIO was first published,
> its internal name was "Industrial I/O" ;-)
>   
lol. We could try and make it the standard working name for all new
subsystems ;)
--
Jonathan Cameron
