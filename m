From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: added spi_resource management
Date: Wed, 2 Dec 2015 14:53:23 +0100
Message-ID: <2F8F8F8D-6351-4F76-B18B-403F84E0E164@martin.sperl.org>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org> <1448888695-2260-2-git-send-email-kernel@martin.sperl.org> <20151201210410.GU1929@sirena.org.uk> <56C9120A-8979-4156-B3C4-5851D695BDF0@martin.sperl.org> <20151202122953.GG1929@sirena.org.uk> <565EEC58.4040006@martin.sperl.org> <20151202133232.GK1929@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151202133232.GK1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 02.12.2015, at 14:32, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> On Wed, Dec 02, 2015 at 02:04:24PM +0100, Martin Sperl wrote:
>=20
>> The bigger question (based on your comments to Patch 2/3) is:
>=20
> I haven't even looked at your reply ot that yet.
>=20
>> Do you want to follow the devres approach (i.e: hiding
>> "struct spi_res" after allocation and returning "void *"
>> to the data-payload only in spi_res_alloc)?
>=20
>> Or do you prefer to have "struct spi_res" as an explicit member of
>> a structure (i.e. in Patch 2/3 "struct spi_res_replaced_transfers")?
>=20
> I wasn't aware that was an issue?

Here the section from your reply to the other patch I am referring to:
> On 01.12.2015, at 22:29, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20

>>=20
>> +/* the spi_resource structure used */
>> +struct spi_res_replaced_transfers {
>> +	spi_res_release_t release;
>> +	struct list_head replaced_transfers;
>> +	int inserted;
>> +	struct spi_transfer xfers[];
>> +};
>=20
> This quite clearly isn't a struct spi_resource, nor does it contain
> one=E2=80=A6

As said: it could also get written as:
+/* the spi_resource structure used */
+struct spi_res_replaced_transfers {
+	struct spi_res resource;
+	spi_res_release_t release;
+	struct list_head replaced_transfers;
+	int inserted;
+	struct spi_transfer xfers[];
+};

But we loose the ability to just allocate memory the way we use
devm_kmalloc.

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
