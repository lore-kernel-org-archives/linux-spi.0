From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Accelerometer, Gyros and ADC's etc within the kernel.
Date: Wed, 21 May 2008 15:20:09 +0200
Message-ID: <20080521152009.0a227c3e@hyperion.delvare>
References: <4832A211.4040206@gmail.com>
	<20080520132817.03fb74ea@hyperion.delvare>
	<20080520214005.GH3220@local>
	<4833F3B6.6020806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Hans J. Koch" <hjk@linutronix.de>, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Dmitry Torokhov <dtor@mail.ru>
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934589AbYEUNUg@vger.kernel.org>
In-Reply-To: <4833F3B6.6020806@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 21 May 2008 11:04:38 +0100, Jonathan Cameron wrote:
> Definitely agreed that it makes sense to put DACs and ADCs in the same 
> general place and obviously there are plenty of devices out there that do
> both.

Note that hardware monitoring chips can include ADCs and DACs: the
former to monitor system voltages, and the later to control fans (most
chips use PWM for that but a few use DACs.) ADCs and DACs are, much
like GPIOs, usable for a variety of different purposes. I doubt that
there would be any benefit in abstracting DACs and ADCs the way we did
for GPIOs, but the important point here is that we really want to group
the drivers according to their functionality and not technical
implementation details.

-- 
Jean Delvare
