From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
Date: Fri, 8 Oct 2010 01:11:49 -0500
Message-ID: <5FE2FD44-A491-4E7C-86E9-5247B9598AD2@kernel.crashing.org>
References: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
	<AANLkTinBDdEyMDt3KoauNdmTCz1ZAJ5mZ23iMWiwsUm4@mail.gmail.com>
	<AANLkTi=GydTyhf3TOzCZOtrme1Jh0UmNDHqTVP59q=LH@mail.gmail.com>
	<20100930150633.GA13741@oksana.dev.rtsoft.ru>
	<73839B4A0818E747864426270AC332C3057F6138@zmy16exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net,
	Gala Kumar-B11780 <B11780@freescale.com>
To: Hu Mingkai-B21284 <B21284@freescale.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <73839B4A0818E747864426270AC332C3057F6138@zmy16exm20.fsl.freescale.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org


On Oct 7, 2010, at 9:15 PM, Hu Mingkai-B21284 wrote:

>>>> Yes, I agree with David on this.  If large transfers don't work,
>>>> then it is the SPI master driver that is buggy.
>>> 
>>> By the way, does this fix your problem?
>>> 
>>> https://patchwork.kernel.org/patch/184752/
>> 
>> It shouldn't. AFAIK, eSPI is PIO-only controller, and the overrun fix is for the
>> DMA mode.
>> 
>> Thanks,
>> 
>> p.s. Btw, in patch 3/7, is_dma_mapped argument of fsl_espi_bufs() is unneeded.
>> 
> 
> Yes, the is_dma_mapped isn't needed, I'll remove it.
> 
> Thanks,
> Mingkai

I'd be really nice if we could close on this patchset in time for .37 acceptance.  I'm guessing that cutoff is quickly approaching.

- k
