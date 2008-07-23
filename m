From: David Brownell <david-b@pacbell.net>
Subject: Re: [Patch 0/4] IndustrialIO subsystem (ADCs, accelerometers etc)
Date: Wed, 23 Jul 2008 11:36:25 -0700
Message-ID: <200807231136.26115.david-b@pacbell.net>
References: <488763AD.4050400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>,
	Dmitry Torokhov <dtor@mail.ru>,
	"Hans J. Koch" <hjk@linutronix.de>, hmh@hmh.eng.br,
	mgross@linux.intel.com, Ben Nizette <bn@niasdigital.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754987AbYGWSjy@vger.kernel.org>
In-Reply-To: <488763AD.4050400@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 23 July 2008, Jonathan Cameron wrote:
> * Software ring buffer support to allow semi regular capture of data =
form the
> =A0 device. =A0Typically this will be driven from either datardy even=
ts, or from
> =A0 a periodic timer interrupt (to this end a very simple wrapper for=
 periodic
> =A0 RTC's is included. This will move to more generic timer interface=
s as and when
> =A0 they become available. =A0For now available rtc's must be registe=
red with the
> =A0 subsystem via the industrialio_register_ptimer function form with=
in a board
> =A0 init.

Could you elaborate a bit on why you'd want hardware supported
periodic timers, rather than either an hrtimer or a timer?
Maybe provide some real-world scenarios where those software
abstractions are inappropriate.

I can imagine numerous reasons, but those might not be yours...

- Dave
