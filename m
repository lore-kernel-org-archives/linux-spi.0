From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] ARM: Add spi controller driver support for NUC900
Date: Thu, 19 Nov 2009 14:23:49 +0800
Message-ID: <e68bb3470911182223r28e9bac0lf185c1443168ff52@mail.gmail.com>
References: <4B024748.9080001@gmail.com>
	 <20091118142109.ff2c5ef6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <spi-devel-general@lists.sourceforge.net>,
	David Brownell-sourceforge <dbrownell@users.sourceforge.net>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751948AbZKSGXp@vger.kernel.org>
In-Reply-To: <20091118142109.ff2c5ef6.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dear Andrew,

Thanks a lot for your help, and I have a question below.

2009/11/19 Andrew Morton <akpm@linux-foundation.org>:
> On Tue, 17 Nov 2009 14:48:40 +0800
> Wan ZongShun <mcuos.com@gmail.com> wrote:
>
>> Dear David,
>>
>> Add winbond/nuvoton NUC900 spi controller driver support,
>> on my evaluation board,there is a winbond w25x16 spi flash,
>> so I test my spi controller driver with m25p80.c.
>>
>>
>> ...
>>
>> +static inline struct w90p910_spi *to_hw(struct spi_device *sdev)
>> +{
>> + =C2=A0 =C2=A0 return spi_master_get_devdata(sdev->master);
>> +}
>> +
>> +static void w90p910_slave_seclect(struct spi_device *spi, unsigned =
int ssr)
>
> I think you meant "select" here?
>
>> +{
>> + =C2=A0 =C2=A0 struct w90p910_spi *hw =3D to_hw(spi);
>> + =C2=A0 =C2=A0 unsigned int val;
>> + =C2=A0 =C2=A0 unsigned int cs =3D spi->mode & SPI_CS_HIGH ? 1 : 0;
>> + =C2=A0 =C2=A0 unsigned int cpol =3D spi->mode & SPI_CPOL ? 1 : 0;
>> +
>> + =C2=A0 =C2=A0 val =3D __raw_readl(hw->regs + USI_SSR);
>> +
>> + =C2=A0 =C2=A0 if (!cs)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &=3D ~SELECTLEV;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D SELECTLEV;
>> +
>> + =C2=A0 =C2=A0 if (!ssr)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &=3D ~SELECTSLAVE;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D SELECTSLAVE;
>> +
>> + =C2=A0 =C2=A0 __raw_writel(val, hw->regs + USI_SSR);
>> +
>> + =C2=A0 =C2=A0 val =3D __raw_readl(hw->regs + USI_CNT);
>> +
>> + =C2=A0 =C2=A0 if (!cpol)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &=3D ~SELECTPOL;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D SELECTPOL;
>> +
>> + =C2=A0 =C2=A0 __raw_writel(val, hw->regs + USI_CNT);
>> +}
>
> That's a read-modify-write operation. =C2=A0What locking prevents two
> threads of control from altering the USI_SSR and USI_CNT registers at
> the same time, resulting in an indeterminate setting?
>
>> +static void w90p910_spi_chipsel(struct spi_device *spi, int value)
>> +{
>> + =C2=A0 =C2=A0 switch (value) {
>> + =C2=A0 =C2=A0 case BITBANG_CS_INACTIVE:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910_slave_seclect(sp=
i, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> +
>> + =C2=A0 =C2=A0 case BITBANG_CS_ACTIVE:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910_slave_seclect(sp=
i, 1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 }
>> +}
>> +
>> +static void w90p910_spi_setup_txnum(struct w90p910_spi *hw,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int txnum)
>> +{
>> + =C2=A0 =C2=A0 unsigned int val;
>> +
>> + =C2=A0 =C2=A0 val =3D __raw_readl(hw->regs + USI_CNT);
>> +
>> + =C2=A0 =C2=A0 if (!txnum)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &=3D ~TXNUM;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D txnum << 0x08;
>> +
>> + =C2=A0 =C2=A0 __raw_writel(val, hw->regs + USI_CNT);
>> +
>> +}
>> +
>> +static void w90p910_spi_setup_txbitlen(struct w90p910_spi *hw,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int txbitlen)
>> +{
>> + =C2=A0 =C2=A0 unsigned int val;
>> +
>> + =C2=A0 =C2=A0 val =3D __raw_readl(hw->regs + USI_CNT);
>> +
>> + =C2=A0 =C2=A0 val |=3D (txbitlen << 0x03);
>> +
>> + =C2=A0 =C2=A0 __raw_writel(val, hw->regs + USI_CNT);
>> +}
>> +
>> +static void w90p910_spi_gobusy(struct w90p910_spi *hw)
>> +{
>> + =C2=A0 =C2=A0 unsigned int val;
>> +
>> + =C2=A0 =C2=A0 val =3D __raw_readl(hw->regs + USI_CNT);
>> +
>> + =C2=A0 =C2=A0 val |=3D GOBUSY;
>> +
>> + =C2=A0 =C2=A0 __raw_writel(val, hw->regs + USI_CNT);
>> +}
>
> ditto, ditto, ditto.
>
>> +static int w90p910_spi_setupxfer(struct spi_device *spi,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct spi_transfer *t)
>> +{
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int w90p910_spi_setup(struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static inline unsigned int hw_txbyte(struct w90p910_spi *hw, int co=
unt)
>> +{
>> + =C2=A0 =C2=A0 return hw->tx ? hw->tx[count] : 0;
>> +}
>> +
>> +static int w90p910_spi_txrx(struct spi_device *spi, struct spi_tran=
sfer *t)
>> +{
>> + =C2=A0 =C2=A0 struct w90p910_spi *hw =3D to_hw(spi);
>> +
>> + =C2=A0 =C2=A0 hw->tx =3D t->tx_buf;
>> + =C2=A0 =C2=A0 hw->rx =3D t->rx_buf;
>> + =C2=A0 =C2=A0 hw->len =3D t->len;
>> + =C2=A0 =C2=A0 hw->count =3D 0;
>> +
>> + =C2=A0 =C2=A0 init_completion(&hw->done);
>> +
>> + =C2=A0 =C2=A0 __raw_writel(hw_txbyte(hw, 0x0), hw->regs + USI_TX0)=
;
>> +
>> + =C2=A0 =C2=A0 w90p910_spi_gobusy(hw);
>> +
>> + =C2=A0 =C2=A0 wait_for_completion(&hw->done);
>> +
>> + =C2=A0 =C2=A0 return hw->count;
>> +}
>
> The init_completion() should be unneeded? =C2=A0The structure was
> initialised at setup time and will be left in a reusable state after =
a
> complete()/wait_for_completion(). =C2=A0Reinitialising the structure =
all the
> time like this adds risk that it will be scribbled on while in use.
>
>>
>> ...
>>
>> +static int __devexit w90p910_spi_remove(struct platform_device *dev=
)
>> +{
>> + =C2=A0 =C2=A0 struct w90p910_spi *hw =3D platform_get_drvdata(dev)=
;
>> +
>> + =C2=A0 =C2=A0 platform_set_drvdata(dev, NULL);
>> +
>> + =C2=A0 =C2=A0 spi_unregister_master(hw->master);
>> +
>> + =C2=A0 =C2=A0 clk_disable(hw->clk);
>> + =C2=A0 =C2=A0 clk_put(hw->clk);
>
> As far as I can tell, a hardware interrupt could still be pending, or
> be under service while the above code is executing?
>
> If so, I expect bad things will happen?

Do you mean that I should put this 'free_irq()' in the front of
w90p910_spi_remove=EF=BC=9F

such as:
"
free_irq(hw->irq, hw);

platform_set_drvdata(dev, NULL);

spi_unregister_master(hw->master);

clk_disable(hw->clk);
clk_put(hw->clk);
"

>> + =C2=A0 =C2=A0 free_irq(hw->irq, hw);
>> + =C2=A0 =C2=A0 iounmap(hw->regs);
>> +
>> + =C2=A0 =C2=A0 release_resource(hw->ioarea);
>> + =C2=A0 =C2=A0 kfree(hw->ioarea);
>> +
>> + =C2=A0 =C2=A0 spi_master_put(hw->master);
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>>
>> ...
>>
>
>



--=20
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
