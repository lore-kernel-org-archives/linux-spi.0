Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAABE3B7775
	for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831542; cv=pass; b=IGd7D0mGSnCy4YI/0AWz3CPlCIxV7oIXk/9+skGSKKNWj6CWe4bhwUs3koDO2pyN0sskp4FIhwCQBqdZgDdkxQyI2H2psMPgQe6PDAMtUmhf6NvVTfjIH879kRfJDSRgp/Hmt+7LZWRfdzxK4g8oNwzxBgdkYkI6Q0/yENKLVXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831542; c=relaxed/simple;
	bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdZ0gO+QHRYIH9GdMkC+tSWxZ/OZTaYnzgTHpWBosYgpGF4iDsjueqvsp03B7QD+g6BVJR1qaZa77eEz2Zy21FaimEz1gQNu2ZiOwL4wdc6o04HSqMkRmWt9E/Tj2mDxDN/IqUX2z4LAS5+FdcVW7rwmZSfqJ0hq/tbbcbwbO4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Y+F4gIrC; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Y+F4gIrC"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a5a37113aso28012327b3.2
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 03:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773831537; cv=none;
        d=google.com; s=arc-20240605;
        b=InIyn9GTby0fEZNQNB6sXDTlOkpUU9C0Br1JFVpnuJJaR0cGGrnqRBiZPdP9gMK8ay
         hpCDgNx3B+bJl14OCFlwSxlFiHa2sYXoJKdMc+au14WKA+rFoma1p/YFD0UI9BmwRRGS
         tutDYmPdi7S02M+kg+7X4rULYG5eG56revkcNan2DbsTcJ8/HkJq3S0eYOp8BNr80Lid
         IwIC4p9y3SasTA2aK8/tFv4raO/sCEC2bNbdA4LKZWVO+xDJFDxWOjQQBG7jmCUc6ptx
         9fk5FEmAW1flwiZo6sZFGiNW2bkJ0DQqb8kZ6j/BIvVGjKW+Cb+9dhFzjJJlfY6UXxXo
         8k8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
        fh=3biTc7X4l//eBI6ft7BMXCWbSs1EJjpqRVk2FA4dvNk=;
        b=DfD8hUV+CTrKaXSSaY4Cc7u8mmsgl8TUbLb3B8oqD63F4iNjq33OlE9nQQzt1sYUqw
         oxJNKaFZJAilDkw2c9RPdtJn3fD6C6Np9RINNzdpd7hLodoZz2boRe6+qhL979mjb+2o
         Gis79ukBPsO/eneNNUXAEd7kWgiOIcoIn2ULPEOWTJYr6taJi8f+C+9lo2eDQYkcz0Kz
         hFwFtumPSZ9z5oAX0PWkTkPDOLFh6671iz/WgWiB0uOVt1TTFqcM1k7fImMNrlWmBc6m
         5fnMM4uHkV6AI07u1ZSddJWnY2asCMloXR3iTjC2HGfDKIVrxkKj19qHAC1+IQZPzAuc
         Tplg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773831537; x=1774436337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
        b=Y+F4gIrCy3AlMDM7CSYzAY8MdpN5nfDAenVYSS8jF8/QGMe0BtbaqtvpoNu4HHsdwI
         eCHGz033wV+iu7o9yHNzl8ab1W8iVYNVNBYMUrCHRQLI9DZgf1n+KJ5WGJM874ZC8E1f
         V8AfDwxwo6eY0vCZpRljMsNdbb7jgkZbz3BUBCDiRZdtki+wXyJ231XN2e5CQzBOtHl2
         RNzehobgF8tA59rhsLrK604RjKLDzwzujNWXDWsClMTvJ5qFhXeMw/pwvPnR1XkeD7qu
         tmTv/A7/XayQthiGv4k2dz99RPffdzi9GNohb9QPIB0xHVtAoLzYczErYFx/GTFFdjmi
         QFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773831537; x=1774436337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
        b=LCmeCU92EqoffQ0WzCNtkJTTkuTkcx9aVGT/vBHJkUpXznzLQ3t/kD0dtwdeJv4QnP
         LEYzFdkyiAnlbJ5gATNDGgXTvrJU7jm5ojhUiqYs3Xnjz5Br1t9VNWRDeCMCYQTyIemW
         oXKkeQANSlfOHUzBBJwFT0GlTSrlC+zUDD/B3x/RrLaZYCKyNaxTH3aGj/DVos6N4TBu
         qY/NyTQYGLug7EM7lgf/C8GmS4mIz07ZMt6Bsnko74JnyjZllVTT3Vxb6u/vSCYqC0ja
         RX1Vm0wsy3EHhNdMkEtgpgfWnZGj/tYlmLRZ/hd48oERAxFCv0JxrlrgkFL/LT9XO2Sk
         w77w==
X-Forwarded-Encrypted: i=1; AJvYcCXWdzF6GeCXnCD9j8EICK0fAJmx/p9JFqiRhtwiaZlEMEetsXzSwtrCjhTh/B/Fqm4EaF9S1yPbNIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPWiOnoKPrQonznlYwLPSdsPD05qSagnt+Czg/Jb8hBucYs6Np
	VyYaButQ5oJ3SNdWdBasRXDgnu2LehPaAsjyaXrwX9FGbv2NXoD9mBAp24OldBK9RSotyTGS/DW
	s4QfiKdiqc3Nz9gk4711qE+962KFewImseioHHSGybA==
X-Gm-Gg: ATEYQzw7NCq71yGYBI/vA+18k4Xhed9Z2MwefhpHKJ1WsvONLPdB1QXztDi7kEVBZj7
	ATSVCP9Rdcbuu/NezE57B48BolUAa/j5OM9dLxVTqYd5wYAiM4HT5MHXEXolcb0E+s3dhE/B4wF
	z0s98DeJ4aTFCLQfucJh7ABRPh71fAQNvlaHYAJfsXEqI05FZ/v556P635m6Dr0gHY2YxI0UFLk
	sbHOmcpNT/UmResHrDCSUeGV3g+B7zRHRxLAnrObMhQnyGGq/f+I7quIfqr5TtzEnxCwp3GGelE
	40tiGDA=
X-Received: by 2002:a05:690c:c50e:b0:79a:3a33:933 with SMTP id
 00721157ae682-79a71ad413dmr29714557b3.31.1773831537485; Wed, 18 Mar 2026
 03:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com> <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com> <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com> <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
 <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com>
 <20260312130255.6476e560@gandalf.local.home> <CAO7JXPgHYZ9zF1HFahb2447X85YRZCQQBHB6ihOwKSDtiZi8kQ@mail.gmail.com>
 <20260317120049.6a60fa88@gandalf.local.home> <6ca9f884-9566-4a82-9995-4c802a0bf8a0@efficios.com>
In-Reply-To: <6ca9f884-9566-4a82-9995-4c802a0bf8a0@efficios.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 06:58:46 -0400
X-Gm-Features: AaiRm52iP799baA3h48fwfLjW02Pe87nEMlmDoXLIPKYRV2LFYQQkuww_KlSUU0
Message-ID: <CAO7JXPgbERfc_P+aPFB1+nR5ua3mZGbhdkbxCr0TFR4Cr6Khuw@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	io-uring@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, dev@openvswitch.org, 
	Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
	dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
	Eddie James <eajames@linux.ibm.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 12:02=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-03-17 12:00, Steven Rostedt wrote:
> > On Fri, 13 Mar 2026 10:02:32 -0400
> > Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
> >
> >>>
> >>> Perhaps: call_trace_foo() ?
> >>>
> >> call_trace_foo has one collision with the tracepoint
> >> sched_update_nr_running and a function
> >> call_trace_sched_update_nr_running. I had considered this and later
> >> moved to trace_invoke_foo() because of the collision. But I can rename
> >> call_trace_sched_update_nr_running to something else if call_trace_foo
> >> is the general consensus.
> >
> > OK, then lets go with: trace_call__foo()
> >
> > The double underscore should prevent any name collisions.
> >
> > Does anyone have an objections?
> I'm OK with it.
>
Great thanks! I shall send a v2 with s/trace_invoke_foo/trace_call__foo/ so=
on.

Thanks,
Vineeth
