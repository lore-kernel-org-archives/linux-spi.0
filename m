From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2 11/15] MIPS: lantiq: Add a GPHY driver which uses the
 RCU syscon-mfd
Date: Thu, 25 May 2017 20:53:43 +0200
Message-ID: <365b80ab-9e40-df65-05a5-58b62b082081@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de>
 <20170521130918.27446-12-hauke@hauke-m.de>
 <CAHp75VdSAGv0md8YsvwdZJX4Eo-K6Tv3TcyAVKfOmdk6De1iGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "martin.blumenstingl" <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
        john <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "hauke.mehrtens" <hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VdSAGv0md8YsvwdZJX4Eo-K6Tv3TcyAVKfOmdk6De1iGQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 05/23/2017 09:52 AM, Andy Shevchenko wrote:
> On Sun, May 21, 2017 at 4:09 PM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
> 
>> Compared to the old xrx200_phy_fw driver the new version has multiple
>> enhancements. The name of the firmware files does not have to be added
>> to all .dts files anymore - one now configures the GPHY mode (FE or GE)
>> instead. Each GPHY can now also boot separate firmware (thus mixing of
>> GE and FE GPHYs is now possible).
>> The new implementation is based on the RCU syscon-mfd and uses the
>> reeset_controller framework instead of raw RCU register reads/writes.
> 
>> +static int xway_gphy_load(struct platform_device *pdev,
>> +                         const char *fw_name, dma_addr_t *dev_addr)
>> +{
>> +       const struct firmware *fw;
>> +       void *fw_addr;
>> +       size_t size;
>> +       int ret;
>> +
> 
>> +       dev_info(&pdev->dev, "requesting %s\n", fw_name);
> 
> Noise.

I will remove this.

> 
>> +       ret = request_firmware(&fw, fw_name, &pdev->dev);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "failed to load firmware: %s, error: %i\n",
>> +                       fw_name, ret);
>> +               return ret;
>> +       }
>> +
> 
>> +       /*
>> +        * GPHY cores need the firmware code in a persistent and contiguous
>> +        * memory area with a 16 kB boundary aligned start address
> 
> Add period to the end.

Ok

>> +        */
> 
>> +static int xway_gphy_of_probe(struct platform_device *pdev,
>> +                               struct xway_gphy_priv *priv)
>> +{
> 
>> +       priv->gphy_reset = devm_reset_control_get(&pdev->dev, "gphy");
>> +       if (IS_ERR_OR_NULL(priv->gphy_reset)) {
> 
> _OR_NULL part looks suspicious.
> There is _optional() variant of reset API, AFAIR.

The OR_NULL part is just wrong I will remove it.

>> +               if (PTR_ERR(priv->gphy_reset) != -EPROBE_DEFER)
>> +                       dev_err(&pdev->dev, "Failed to lookup gphy reset\n");
>> +               return PTR_ERR(priv->gphy_reset);
>> +       }
> 
>> +       priv->gphy_reset2 = devm_reset_control_get_optional(&pdev->dev, "gphy2");
>> +       if (IS_ERR(priv->gphy_reset2)) {
>> +               if (PTR_ERR(priv->gphy_reset2) == -EPROBE_DEFER)
>> +                       return PTR_ERR(priv->gphy_reset2);
> 
>> +               priv->gphy_reset2 = NULL;
> 
> Why?
> 
> If there is a problem in reset framework it should be fixed there, not here.

I think this was a workaround for an already fixed bug in the reset
controller framework, it will be removed.

>> +       }
>> +
>> +       if (of_property_read_u32(np, "lantiq,gphy-mode", &gphy_mode))
> 
>> +               /* Default to GE mode */
> 
> If you put more lines in the branch you perhaps need {}.

OK

>> +               gphy_mode = GPHY_MODE_GE;
> 
>> +static int xway_gphy_probe(struct platform_device *pdev)
>> +{
>> +       struct xway_gphy_priv *priv;
>> +       dma_addr_t fw_addr = 0;
>> +       int ret;
> 
>> +       if (!IS_ERR_OR_NULL(priv->gphy_clk_gate))
> 
> _OR_NULL is redundant.
> IS_ERR should not happen here if clock is mandatory.

This clock is optional, I will check the error before.

> Thus, complete line is redundant.
> 
>> +               clk_prepare_enable(priv->gphy_clk_gate);
> 
> You need to check return value.
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
