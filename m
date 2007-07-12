From: David Vrabel <david.vrabel@csr.com>
Subject: Re: pxa2xx_spi: PXA27x SSP1 doesn't work with DMA
Date: Thu, 12 Jul 2007 16:54:51 +0100
Message-ID: <46964ECB.3070500@csr.com>
References: <200707100913.22574.david-b@pacbell.net>
	<1184171175.6762.17.camel@truckin.grid-net.com>
	<200707111008.11363.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.arm.linux.org.uk
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <200707111008.11363.david-b@pacbell.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> On Wednesday 11 July 2007, Stephen Street wrote:
>> This is fine.  When I get more time, I will re-think handling of PXA2xx
>> version differences.
> 
> Except it's against 2.6.16 and doesn't apply against 2.6.22 ... which
> doesn't have those switch statements!

Oops.  I checked to see if this driver had changed but thought it hadn't...

> David, could you provide a fix for current kernels?

I could, but I couldn't test it :(

David


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

To get further information regarding CSR, please visit our Investor Relations page at http://ir.csr.com/csr/about/overview

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
