From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] pxa2xx_spi: fix memory corruption
Date: Fri, 15 Jul 2011 09:12:42 +0100
Message-ID: <20110715081242.GM23270@n2100.arm.linux.org.uk>
References: <201107101609.31405.anarsoul@gmail.com>
	<1310311099-24638-1-git-send-email-anarsoul@gmail.com>
	<20110715025331.GL2927@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Eric Miao <eric.y.miao@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110715025331.GL2927@ponder.secretlab.ca>
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

On Thu, Jul 14, 2011 at 08:53:31PM -0600, Grant Likely wrote:
> > +	u8 null_dma_buf_unaligned[16];
> 
> Don't dma buffers need to be cache-line aligned?  How large is the
> actual transfer?  Using the __aligned() or __cacheline_aligned
> attribute is the correct way to make sure you've got a data buffer
> that can be used for DMA mixed with other stuff.  Then you don't need
> to fool around with PTR_ALIGN or anything.

Err, did you not read the whole patch?

> > +	drv_data->null_dma_buf =
> > +		(u32 *)PTR_ALIGN(&drv_data->null_dma_buf_unaligned, 8);
