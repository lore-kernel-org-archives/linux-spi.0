From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [spi-devel-general] [Patch 0/4] IndustrialIO subsystem (ADCs,
 accelerometers etc)
Date: Thu, 24 Jul 2008 10:19:57 +0100
Message-ID: <20080724101957.75bf03e0@lxorguk.ukuu.org.uk>
References: <488763AD.4050400@gmail.com>
	<20080723191918.GC26938@trinity.fluff.org>
	<20080724074124.GB2254@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-linux@fluff.org>,
	Jonathan Cameron <Jonathan.Cameron@gmail.com>,
	mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>,
	LKML <linux-kernel@vger.kernel.org>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	David Brownell <david-b@pacbell.net>, hmh@hmh.eng.br,
	Jean Delvare <khali@linux-fr.org>,
	spi-devel-general@lists.sourceforge.net,
	Ben Nizette <bn@niasdigital.com>
To: "Hans J. Koch" <hjk@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754570AbYGXJk4@vger.kernel.org>
In-Reply-To: <20080724074124.GB2254@local>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> hwmon is designed for slow I/O. It won't handle an ADC that does a few
> megasamples/sec.

At that rate I would assume you want a memory mapped ring buffer or
similar not a sysfs style interface ?
