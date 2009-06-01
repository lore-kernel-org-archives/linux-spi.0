From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 1/1] ARM PL022 SSP/SPI driver v2
Date: Mon, 1 Jun 2009 16:03:45 +0200
Message-ID: <63386a3d0906010703j672cc8d0h8c566658dfa08d35@mail.gmail.com>
References: <63386a3d0906010502o6d2bee3erf6b8229000f050c0@mail.gmail.com>
	<20090601120744.GA15968@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Linus Walleij <linus.walleij@stericsson.com>,
	Alessandro Rubini <rubini-list@gnudd.com>,
	Baruch Siach <baruch@tkos.co.il>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090601120744.GA15968@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

2009/6/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Mon, Jun 01, 2009 at 02:02:39PM +0200, Linus Walleij wrote:
>> +#include <asm/irq.h>
>
> Last question from me I think - does it actually require this include?
> (it's nice to see drivers without any asm/ includes.)

It was unnecessary, so removed for v3.

Linus Walleij

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
