From: Huang Shijie <shijie8@gmail.com>
Subject: Re: [PATCH v3 2/7] mtd: spi-nor: add the basic data structures
Date: Wed, 18 Dec 2013 00:00:52 +0800
Message-ID: <20131217160050.GA1279@gmail.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <201312171405.55964.marex@denx.de>
 <20131217134923.GA1220@gmail.com>
 <201312171616.57029.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Huang Shijie <b32955@freescale.com>, angus.clark@st.com,
	shawn.guo@linaro.org, b44548@freescale.com, broonie@linaro.org,
	dwmw2@infradead.org, linux-doc@vger.kernel.org,
	b18965@freescale.com, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org, pekon@ti.com, sourav.poddar@ti.com,
	computersforpeace@gmail.com, lee.jones@linaro.org,
	linux-arm-kernel@lists.infradead.org
To: Marek Vasut <marex@denx.de>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201312171616.57029.marex@denx.de>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 17, 2013 at 04:16:56PM +0100, Marek Vasut wrote:
> On Tuesday, December 17, 2013 at 02:49:25 PM, Huang Shijie wrote:
> > On Tue, Dec 17, 2013 at 02:05:55PM +0100, Marek Vasut wrote:
> > > On Monday, December 16, 2013 at 09:58:45 AM, Huang Shijie wrote:
> > > > +struct spi_nor { > > +	struct mtd_info		*mtd;
> > > > +	struct mutex		lock;
> > > > +
> > > > +	/* pointer to a spi device */
> > > > +	struct device		*dev;
> > > > +	u32			page_size;
> > > > +	u8			addr_width;
> > > > +	u8			erase_opcode;
> > > > +	u8			read_opcode;
> > > > +	u8			read_dummy;
> > > > +	u8			program_opcode;
> > > > +	enum read_mode		flash_read;
> > > > +	bool			sst_write_second;
> > > > +	struct spi_nor_xfer_cfg	cfg;
> > > 
> > > You do want to split the function pointers below and the device
> > > configuration above into separate structures.
> > 
> > sorry, i prefer to keep them in one data structrue, just like the
> > nand_chip{} does.
> 

Take @read_reg for example, currently, we call it with nor->read_reg();
If we add a new data structrue for these hooks, we wil call it with
nor->ops->read_reg().

So just like the nand_chip{}, make the code more simple.


thanks
Huang Shijie


