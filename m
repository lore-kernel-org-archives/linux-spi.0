From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
Date: Wed, 8 Feb 2012 17:26:39 +0100
Message-ID: <20120208162639.GJ15647@game.jcrosoft.org>
References: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: workgroup.linux@csr.com, Zhiwu Song <zhiwu.song@csr.com>,
 grant.likely@secretlab.ca, Barry Song <Baohua.Song@csr.com>,
 spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
To: Barry Song <21cnbao@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
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

 +
> +static int spi_sirfsoc_setup(struct spi_device *spi)
> +{
> +	struct spi_bitbang *bitbang;
> +	struct sirfsoc_spi *sspi;
> +
> +	if (!spi->max_speed_hz)
> +		return -EINVAL;
> +
> +	sspi = spi_master_get_devdata(spi->master);
> +	bitbang = &sspi->bitbang;
why do you need this?
> +
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word = 8;
> +
> +	return spi_sirfsoc_setup_transfer(spi, NULL);
> +}

Best Regards,
J.
