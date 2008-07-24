From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [Patch 0/4] IndustrialIO subsystem (ADCs, accelerometers etc)
Date: Fri, 25 Jul 2008 00:25:49 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807250025080.11551@fbirervta.pbzchgretzou.qr>
References: <488763AD.4050400@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>,
	Dmitry Torokhov <dtor@mail.ru>,
	"Hans J. Koch" <hjk@linutronix.de>, hmh@hmh.eng.br,
	David Brownell <david-b@pacbell.net>, mgross@linux.intel.com,
	Ben Nizette <bn@niasdigital.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753957AbYGXW0I@vger.kernel.org>
In-Reply-To: <488763AD.4050400@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On Wednesday 2008-07-23 19:00, Jonathan Cameron wrote:

>Dear All,
>
>The need for an industrialio subsystem was discussed in
>http://lkml.org/lkml/2008/5/20/135
>
>Firstly thanks to all the people who have contributed to the discussion
>of this in the past.
>
>In brief the intention is provide a kernel subsystem directed towards the
>handling on sensors (and later related output devices) such as ADC's,
>accelerometers and many others.

Could this be done using UIO instead?
