From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2 v4] atmel/spi: fix missing probe
Date: Thu, 3 Nov 2011 22:47:56 +0000
Message-ID: <20111103224756.GT12913@n2100.arm.linux.org.uk>
References: <1320342082-18573-1-git-send-email-plagnioj@jcrosoft.com>
	<1320343060-18710-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-arm-kernel@lists.infradead.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1320343060-18710-1-git-send-email-plagnioj@jcrosoft.com>
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

On Fri, Nov 04, 2011 at 01:57:40AM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Commit 940ab889 "drivercore: Add helper macro for platform_driver boilerplate"
> converted this driver to use module_platform_driver, but due to the use
> of platform_driver_probe(), this resulted in the call to atmel_spi_probe being
> lost. Place the call to this function into the driver structure.

Let me say again, this should not be the first patch in the series.
If you're trying to fix a bug don't introduce a new bug by fixing
another bug.

If you did this with, say, the VM or FS subsystem, you'll have this
patch reverted.

Moreover, it's bad practice to do "fixes" in this way, especially when
it's trivial to do it _right_ as I've already mentioned several times.

I still maintain that it should be _one_ patch fixing these issues, not
two.
