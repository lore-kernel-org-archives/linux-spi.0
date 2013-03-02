From: "Peter Korsgaard" <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Driver for GPIO controlled SPI multiplexer
Date: Sat, 02 Mar 2013 11:43:58 +0100
Message-ID: <87wqtq3wup.fsf@thor.barco.com>
References: <1361973519-30633-1-git-send-email-peter.korsgaard@barco.com><20130302035043.GE6610@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Van Puymbroeck,
	Dries" <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
To: "Mark Brown" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20130302035043.GE6610-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> (Mark
	Brown'smessage of "Sat, 2 Mar 2013 04:50:45 +0100")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>>>>> "MB" == Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> writes:

Hi,

>> +The property spi-max-frequency is conceptually not needed, as each
>> +child node holds the maximum frequency specific to that
>> +device. However, the SPI core code wants every device in the tree to
>> +specify a maximum frequency. So because the mux is a device to a
>> +parent SPI master, you need to set a maximum frequency.  It's best to
>> +set this high, as the driver will take the minimum of this value and
>> +the child's maximum frequency value when doing a transfer to that
>> +child device.

MB> Can't the device just enumerate its children and DTRT?

Agreed.


>> +static const struct of_device_id spi_mux_gpio_of_match[] = {
>> +	{ .compatible = "spi-mux-gpio", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, spi_mux_gpio_of_match);

MB> This looks wrong without a vendor name in it but I'm not sure what we're
MB> supposed to do for generic stuff like this.

It's atleast in line with what we do elsewhere (spi-gpio, i2c-gpio,
i2c-mux-gpio, ..)

-- 
Bye, Peter Korsgaard


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
