From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH 2/2] SPI: make the moved loopback test
	work
Date: Mon, 19 Jul 2010 18:32:30 -0700 (PDT)
Message-ID: <812288.2599.qm@web180314.mail.gq1.yahoo.com>
References: <AANLkTinm_bvpcQogsTgVy5ZX1MFajVvDxBtVJ056sTyq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Anton Vorontsov <avorontsov@mvista.com>,
	Linus Walleij <linus.ml.walleij@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTinm_bvpcQogsTgVy5ZX1MFajVvDxBtVJ056sTyq@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

> No matter how much I look at it, it seems like
> all use of this require you to first register
> *some* device, 

OBVIOUSLY.  You can't use SPI without a device;
it's like any other driver framework in Linux.
What else should you expect???

Look at the sample code though, ISTR you'll see
that when the SPI master works correctly, putting
it into loopback mode just means that the writes
and reads (should) get the same data -- full duplex.
No matter what the device is (given SPI_LOOP).

- Dave
