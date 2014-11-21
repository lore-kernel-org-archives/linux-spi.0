From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v8 6/8] OF: i2c: Add OF notifier handler
Date: Fri, 21 Nov 2014 17:11:15 +0200
Message-ID: <E28022BF-F72E-4BD9-9F95-4DB091EA7981@konsulko.com>
References: <1414528565-10907-1-git-send-email-pantelis.antoniou@konsulko.com> <1414528565-10907-7-git-send-email-pantelis.antoniou@konsulko.com> <20141121015335.99BF2C413E8@trevor.secretlab.ca> <546E9D75.3000208@roeck-us.net> <20141121150837.20DC4C40D85@trevor.secretlab.ca>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jan Lubbe <jluebbe-H4yykcOXDpCzQB+pC5nmwQ@public.gmane.org>,
	Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>,
	Michael Stickel <ms-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>,
	Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Tull <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Michael Bohan <mbohan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>,
	Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joel Becker <jlbec-aKy9MeLSZ9dg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141121150837.20DC4C40D85-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

> On Nov 21, 2014, at 17:08 , Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> =
wrote:
>=20
> On Thu, 20 Nov 2014 18:03:33 -0800
> , Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> wrote:
>> On 11/20/2014 05:53 PM, Grant Likely wrote:
>>> On Tue, 28 Oct 2014 22:36:03 +0200
>>> , Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>>>  wrote:
>>>> Add OF notifier handler needed for creating/destroying i2c devices
>>>> according to dynamic runtime changes in the DT live tree.
>>>>=20
>>>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>>>> ---
>>>>  drivers/i2c/i2c-core.c | 79 +++++++++++++++++++++++++++++++++++++=
++++++++++++-
>>>>  1 file changed, 78 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>>> index e6da9d3..e751b78 100644
>>>> --- a/drivers/i2c/i2c-core.c
>>>> +++ b/drivers/i2c/i2c-core.c
>>>> @@ -1470,6 +1470,7 @@ struct i2c_adapter *of_find_i2c_adapter_by_n=
ode(struct device_node *node)
>>>>  	return i2c_verify_adapter(dev);
>>>>  }
>>>>  EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
>>>> +
>>>>  #else
>>>>  static void of_i2c_register_devices(struct i2c_adapter *adap) { }
>>>>  #endif /* CONFIG_OF */
>>>> @@ -1955,6 +1956,71 @@ void i2c_clients_command(struct i2c_adapter=
 *adap, unsigned int cmd, void *arg)
>>>>  }
>>>>  EXPORT_SYMBOL(i2c_clients_command);
>>>>=20
>>>> +#if IS_ENABLED(CONFIG_OF)
>>>> +
>>>> +static int of_i2c_notify(struct notifier_block *nb,
>>>> +				unsigned long action, void *arg)
>>>> +{
>>>> +	struct device_node *dn;
>>>> +	struct i2c_adapter *adap;
>>>> +	struct i2c_client *client;
>>>> +	int state;
>>>> +
>>>> +	state =3D of_reconfig_get_state_change(action, arg);
>>>> +	if (state =3D=3D -1)
>>>> +		return NOTIFY_OK;
>>>> +
>>>> +	switch (action) {
>>>> +	case OF_RECONFIG_ATTACH_NODE:
>>>> +	case OF_RECONFIG_DETACH_NODE:
>>>> +		dn =3D arg;
>>>> +		break;
>>>> +	case OF_RECONFIG_ADD_PROPERTY:
>>>> +	case OF_RECONFIG_REMOVE_PROPERTY:
>>>> +	case OF_RECONFIG_UPDATE_PROPERTY:
>>>> +		dn =3D ((struct of_prop_reconfig *)arg)->dn;
>>>> +		break;
>>>> +	default:
>>>> +		return NOTIFY_OK;
>>>> +	}
>>>> +
>>>> +	if (state) {
>>>> +
>>>> +		adap =3D of_find_i2c_adapter_by_node(dn->parent);
>>>> +		if (adap =3D=3D NULL)
>>>> +			return NOTIFY_OK;	/* not for us */
>>>> +
>>>> +		client =3D of_i2c_register_device(adap, dn);
>>>> +		put_device(&adap->dev);
>>>> +
>>>> +		if (IS_ERR(client)) {
>>>> +			pr_err("%s: failed to create for '%s'\n",
>>>> +					__func__, dn->full_name);
>>>> +			return notifier_from_errno(PTR_ERR(client));
>>>> +		}
>>>> +
>>>> +	} else {
>>>> +
>>>> +		/* find our device by node */
>>>> +		client =3D of_find_i2c_device_by_node(dn);
>>>> +		if (client =3D=3D NULL)
>>>> +			return NOTIFY_OK;	/* no? not meant for us */
>>>> +
>>>> +		/* unregister takes one ref away */
>>>> +		i2c_unregister_device(client);
>>>> +
>>>> +		/* and put the reference of the find */
>>>> +		put_device(&client->dev);
>>>> +
>>>> +	}
>>>=20
>>> Nit: odd whitespace
>>>=20
>>>> +
>>>> +	return NOTIFY_OK;
>>>> +}
>>>> +
>>>> +static struct notifier_block i2c_of_notifier;
>>>> +
>>>> +#endif
>>>> +
>>>>  static int __init i2c_init(void)
>>>>  {
>>>>  	int retval;
>>>> @@ -1972,8 +2038,19 @@ static int __init i2c_init(void)
>>>>  	retval =3D i2c_add_driver(&dummy_driver);
>>>>  	if (retval)
>>>>  		goto class_err;
>>>> -	return 0;
>>>>=20
>>>> +#if IS_ENABLED(CONFIG_OF)
>>>> +	i2c_of_notifier.notifier_call =3D of_i2c_notify;
>>=20
>> Wouldn't it be easier to just initialize i2c_of_notifier above inste=
ad of
>> here in the code ? Or is there a reason for doing it here ?
>=20
> Yes, absolutely. This code should also depend on CONFIG_OF_DYNAMIC to=
o,
> not merely CONFIG_OF.
>=20
>>=20

No reason; it just seemed like the most opportune place to put it at th=
e time.

>> Thanks,
>> Guenter
>>=20
>>>> +	retval =3D of_reconfig_notifier_register(&i2c_of_notifier);
>>>> +	if (retval)
>>>> +		goto notifier_err;
>>>> +#endif
>=20
> We can also get rid of the ugly #ifdef in the body by creating empty
> stubs for of_reconfig_notify_{register,unregister}() and doing the
> following:
>=20
> 	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
> 		WARN_ON(of_reconfig_notifier_register(&i2c_of_notifier))
>=20
> I picked up the patch into my tree and made the above changes because
> they're pretty trivial. If Wolfram is okay with it then I can take th=
e
> whole series through my tree. Otherwise I'll put the of_reconfig_* em=
pty
> stubs into a separate branch that he and broonie can both pull.
>=20

I=E2=80=99m fine with doing this if you=E2=80=99d like, it=E2=80=99s pr=
etty simple.

Regards

=E2=80=94 Pantelis

> g.
>=20
>>>> +
>>>> +	return 0;
>>>> +#if IS_ENABLED(CONFIG_OF)
>>>> +notifier_err:
>>>> +	i2c_del_driver(&dummy_driver);
>>>> +#endif
>>>=20
>>> Similar to my comment on the platform bus, don't break the entire b=
us if
>>> registration of the notifier fails. I would drop the error case and=
 just
>>> do a WARN_ON() if it fails.
>>>=20
>>> Otherwise:
>>>=20
>>> Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>=20
>>>>  class_err:
>>>>  #ifdef CONFIG_I2C_COMPAT
>>>>  	class_compat_unregister(i2c_adapter_compat_class);
>>>> --
>>>> 1.7.12
>>>>=20
>>>=20
>>>=20
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
