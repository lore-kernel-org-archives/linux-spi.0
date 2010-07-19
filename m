From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH 2/2] SPI: make the moved loopback test
	work
Date: Mon, 19 Jul 2010 03:16:12 -0700 (PDT)
Message-ID: <377310.49674.qm@web180311.mail.gq1.yahoo.com>
References: <AANLkTikfwTxZ4iMaveddXLd1Z2phF0hVi_yG7A2wUNCo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Linus Walleij <linus.walleij@stericsson.com>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTikfwTxZ4iMaveddXLd1Z2phF0hVi_yG7A2wUNCo@mail.gmail.com>
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

A dedicated loopback test is the wrong model,
given that SPI_LOOP exists.  And is even used
in the sample userspace code ...

- Dave
