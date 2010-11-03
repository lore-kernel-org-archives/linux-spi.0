From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH v4 08/12] gpio: add ti-ssp gpio driver
Date: Wed, 3 Nov 2010 11:18:37 +0100
Message-ID: <AANLkTin=3K0H+YdNM2Nhz63c3+Upp+rwApo-Ww4p5qH6@mail.gmail.com>
References: <1288124308-14999-9-git-send-email-cyril@ti.com>
	<956998.65651.qm@web180302.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: davinci-linux-open-source@linux.davincidsp.com,
	spi-devel-general@lists.sourceforge.net,
	broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk,
	grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rpurdie@rpsys.net,
	Cyril Chemparathy <cyril@ti.com>
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <956998.65651.qm@web180302.mail.gq1.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2010/11/3 David Brownell <david-b@pacbell.net>:

> That seems like
> a better structure for various vendors' "SSP"
> hardware (multifunction serial interface logic)

Incidentally the ARM PrimeCell PL022 is called SSP,
"Synchronous Serial Port" and is not multifunction at all.
Just to add to the confusion...

Yours,
Linus Walleij
