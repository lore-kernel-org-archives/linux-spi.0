From: swingboard <swingboard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
Date: Fri, 5 Sep 2014 11:34:57 +0800
Message-ID: <CA+qxAP06x5uHzObuWzmcAjFz4YKHRxxH5FE5cGZYzKQNUsJdyg@mail.gmail.com>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
	<1409648468-5436-3-git-send-email-Barry.Song@csr.com>
	<20140904191954.GO29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30426ef26178330502492735
Cc: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140904191954.GO29327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--20cf30426ef26178330502492735
Content-Type: text/plain; charset=UTF-8

2014-09-05 3:19 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Tue, Sep 02, 2014 at 05:01:02PM +0800, Barry Song wrote:
>> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>>
>> move spi controller's gpio request work out from probe() to spi device
>> register stage, so after spi device register spi controller can deactive
>> device's gpio chipselect. old code can't do it because gpio request has
>> not be done until device register is finised in spi_bitbang_start.
>> and add cleanup function to free CS gpio.
>
> I'm not quite sure I understand the rationale here - as far as I can
> tell this is making the GPIO request happen later not earlier so it's
> not clear to me what the problem this is fixing in the existing code.
> If the goal is to move the request around in the probe function why not
> just move the existing code earlier in probe()?
>
> This also won't interact well with deferred probe, though a better
> solution here would be some kind of deferred device registration and
> typically the link ordering will mean it won't be an issue when
> everything is built in.

As GPIO cs can be high or low validate and the used GPIO pin with
default value may high or low,
it is need do spi device's chipselect invalidation work in spi_setup,
the patch purpose for it.
master->cs_gpios only assigned after spi_bitbang_start and the
function call spi_setup,
if keep the existing code there will result gpio usage before gpio request.
just move gpio request code in spi_sirfsoc_setup before gpio use.

--20cf30426ef26178330502492735
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 84cb7af1a046aca3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NClZlcnNpb246IEdudVBHIHYyDQoNCmlRSWNC
QUVCQWdBR0JRSlVDTHRYQUFvSkVMU2ljK3Qrb2ltOXBiZ1AvMGtiNTcrczh3VVc1UytxNnN5cWtV
L0MNCkhhYkdTa1Q1SmZPNTBBbjg5eWVJblF0Qk1VQlhmV0wxRjVIaVA3V2dGdlR2eExSSWg3YU9G
QlZ0NFlXaGRteXkNCjk4cWgzQ3FxbHZDcHpxLzB4aGNlQ01ETEJmRTFkeERHRWVPd1RHd1lHVE45
Zkl6V240NVZhcE8wQ0pzVFBHWTkNCmVBK2pvbEpsVnVVV2s1aXA0OEppU1NmYTJpYjBqZGN2V0ha
VjR2VE9JMTY3cURZSzB3MldnbE1IbmlqYktSMVgNClBaSHlmaWovYzR1K1hUYjkydXRGelpSeDh3
WXc5Qmc0TFRqeUppcG1BbWttNER4ME1IQm84VDJuUzdmSFI4Q2sNCnZEQysvemZ6VFVEdGlONXVG
MXpQcm5tUzVnUWU2ZERZQXY0WTJhMjI3dmNieXJNa1M5L1pDc1lIbHVOWVE4ZnkNCmdxUk5uR25z
TmMrcGlacFp5MXVFdjZmZ3FuK2dFQm1xYjZTOTRQem8zaVdrbktCcHlJbFRlY3hTNHJmblBEWTkN
ClUvWFByZzZUbmErTHJLVUZ0SkJid0ZuMGxrR0xkdjNTYTNubGw5WnZlalN4cnh5MVdQbVVQZjJ5
anBMWHBvckcNCkNNbitoaUw2RkRNenpYVXQ0c0c1cUZmNXY1MkNBWHR3THAyQkhxYlkrQzg0UWdN
TXFIZ0ZDRE5IUUo4OTZ3TGENCkV3RGp0Y1JBbUpDQzZwZWJFT0l1cjRGWHlvTXRPdXFaalRaNHZ2
M2FLa2JGeTdKdUxheGxqOEZjR2VNRGtLQXANCkMyTGIxL0tIUG5kT2ZvbXFQV2xpWmRRdzFoTG1O
YTdsaVZFaGRZS2hsYWhJOHc4QXhLaGFZcFh0K1JEYkw1TUENCi9Kc2tON0YxUGtZR1VnbHQxVm50
DQo9NUZZRw0KLS0tLS1FTkQgUEdQIFNJR05BVFVSRS0tLS0tDQo=
--20cf30426ef26178330502492735--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
