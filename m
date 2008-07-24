From: Eric Piel <eric.piel@tremplin-utc.net>
Subject: Re: [Patch 1/4] Industrialio Core
Date: Thu, 24 Jul 2008 11:01:40 +0200
Message-ID: <488844F4.1090809@tremplin-utc.net>
References: <488763AD.4050400@gmail.com> <488765A5.3040703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754572AbYGXJeV@vger.kernel.org>
In-Reply-To: <488765A5.3040703@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Jonathan Cameron schreef:
:
> +
> +static void __exit iio_exit(void)
> +{
> +	unregister_chrdev(IIO_MAJOR, "bob");
bob?! Maybe you meant "industrialio" ?

See you,
Eric
