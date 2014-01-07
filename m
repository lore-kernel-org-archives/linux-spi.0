From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] spi: ti-qspi: Fix getting correct address for qspi
Date: Tue, 7 Jan 2014 16:52:11 +0530
Message-ID: <52CBE363.3060704@ti.com>
References: <1389092643.3991.1.camel@phoenix>	<52CBDF90.3060107@ti.com> <CAFRkauC=5Ls=AUi4HWJPfu3uL2XVP5b6w8U+z8fnqVSTkXPE_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFRkauC=5Ls=AUi4HWJPfu3uL2XVP5b6w8U+z8fnqVSTkXPE_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday 07 January 2014 04:48 PM, Axel Lin wrote:
> 2014/1/7 Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>:
>> On Tuesday 07 January 2014 04:34 PM, Axel Lin wrote:
>>> Now platform_get_drvdata() returns the address of qspi rather than master.
>>> Also drop unneeded spi_unregister_master() call in ti_qspi_remove()
>>> because
>>> we use devm_spi_register_master() in probe.
>>>
>>> commit cbcabb7a300b "spi/qspi: Fix qspi remove path" assumes
>>> platform_get_drvdata() returns address of master. However,
>>> commit 160a061301c7 "spi/qspi: set correct platform drvdata in
>>> ti_qspi_probe()"
>>> pass qspi to platform_set_drvdata().
>>>
>>> Signed-off-by: Axel Lin<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
>>> ---
>>> v2: Update commit log, and drop fixes tag ( the fixes commit id is wrong).
>>>
>>>    drivers/spi/spi-ti-qspi.c | 8 +-------
>>>    1 file changed, 1 insertion(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
>>> index 9190e03..4b413e9 100644
>>> --- a/drivers/spi/spi-ti-qspi.c
>>> +++ b/drivers/spi/spi-ti-qspi.c
>>> @@ -563,13 +563,9 @@ free_master:
>>>
>>>    static int ti_qspi_remove(struct platform_device *pdev)
>>>    {
>>> -       struct spi_master *master;
>>> -       struct ti_qspi *qspi;
>>> +       struct ti_qspi *qspi = platform_get_drvdata(pdev);
>>>          int ret;
>>>
>>> -       master = platform_get_drvdata(pdev);
>>> -       qspi = spi_master_get_devdata(master);
>>> -
>>>          ret = pm_runtime_get_sync(qspi->dev);
>>>          if (ret<   0) {
>>>                  dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
>>> @@ -581,8 +577,6 @@ static int ti_qspi_remove(struct platform_device
>>> *pdev)
>>>          pm_runtime_put(qspi->dev);
>>>          pm_runtime_disable(&pdev->dev);
>>>
>>> -       spi_unregister_master(master);
>>> -
>> why this is removed?
> If you use spi_register_master(), then you need to call spi_unregister_master()
> in  ti_qspi_remove().
> However, current code uses devm_spi_register_master(). So you don't need to
> expilictly call spi_unregister_master(). It's done by devm_* APIs.
>
> Regards,
> Axel

hmm..missed that point.
Reviewed-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
