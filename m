Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6E37BE73
	for <linux-spi@vger.kernel.org>; Sun, 19 Apr 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776604459; cv=pass; b=FsXV2SZhylTobt4S33pnatsXF8jaHkxTPNGd9SQ/fXEdDOg5gYT5ji2UQ1mdvJXFjcRBs78vPFpnHOQYX3I8Q43azlMy4mz2jk39apVW6cftAMFvIe42SjudiIi8+B9HLbEvjCnkdLN0l0CiIqiBnhM/eg1abl9Jd899cqAQI8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776604459; c=relaxed/simple;
	bh=qe/8/rd6eZq24hJL9eY4fBiSEHVVKDLumzkH60jo5p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAwrhNqySPXUL1IZZqtqjlmkjHScxXEN3Y75YEmKai/QHP3APZ1GIqf65FMayetcWmkBAnj4pCXCzUAoorUSl4L/vKRzNDrb8ZMn7GcJIrGUL0C9ynNcFICZ3OREAqNgabPPnFr/qg5lU+EqKg1eS6TVBMTxpPDwJL56CUtw/3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=RF+j7+hH; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="RF+j7+hH"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65318dafbcbso1804312d50.2
        for <linux-spi@vger.kernel.org>; Sun, 19 Apr 2026 06:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776604455; cv=none;
        d=google.com; s=arc-20240605;
        b=f6hvofa4fuhF3NVntKnqLkHTxodw0nw3o0dOe5ugOA24yZzO8dWRvx5VmRXXwH7c4S
         D0N5hMwUpvGgqGD4Yri7hIiJ4D40U6W4NxUl1pCb070zi5XjdIZIsUGmAbotsxOQqDPj
         5j5i/pTxwNyDvwYh/YpAJMQzh5tO68gVRmT8v8Kzb9T356Smu//TWnzwz7R/MMUjfLO9
         phlNq04xk0gGZ5clOZ1W2QFHulrAqjRoyBg/fuWyl7PvzM7AtsUpKbVbXp40ADlHmn82
         dVUOITazcjVJFAhv8EmXSCiHXxgJQ8YKj+C0mdoJFBqmyHYX33vTNfG3j6e2d5qdenM8
         Ed0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
        fh=S8Kpm4xUQAgMIlsujzLBDEYeEcf6YU1APb7xG+tDUtk=;
        b=XEVEi+3D9ZMes+qIsHorrx1wV4IWipkSssW2bl3VvDxjsMF6xByy59xbDcmRONOazh
         A33tAmJDOVTdTXA4WfByPhV1oguea17UQ2N9Ykk/1J5qtirUqr8WWTZhxDz29bX9+qUM
         IHgvR76+9mDToTwUFOQ+MEyT6nkL33eMauFYyx8WcxQuyHxRr1BQN57Gq4uuQuik31XV
         N3OJ+zAj03YcR2z/pbOOIiq1y7CWk65UR5NGkAUiErgJsnut2KScTkzUHVYhwuQcI6Ff
         u8lJrDntf9BAFtOeM6nApjkfuEjpAaFLYb1JFh59MnHpsB74yRT8M1DaJhcyhAN9kgWm
         ZnoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1776604455; x=1777209255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
        b=RF+j7+hHVxK6KZm7vPd2VqoOm/wjdXQLWhOzfortaWaPcUVwcAQrCs3L0CFMuiRg7q
         QnfAqyyLg1KJ+FRhOaVPXbDj/1oQAlKqMc8aZVWWLmxNSIvN0DqnMlIAoJn6kuX0b/7J
         7sPHT3tJByJtn837fhiWKur8kP67w4ITGeKuH61ShAM9KSbiPZhuqcwRf0AI+YYvfUzE
         nm7TFbEi+qyg5VUzXDZfGrK2suVGd+PyZxZUbRBAHRptfz+N0eKCGeaG7itaOxMnDo4a
         9pQYTEUA6X1M/ONh/tBNfIzrR7/o898AAKuwOGzc6VJY9VVEJ/2rd2ZdsoDfuP51zO2Z
         aU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776604455; x=1777209255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
        b=PG5MmoSaCw1GbvNRkbQG0YZ+QjV0T+ypvTCALWWCNdexg0xdbtBg3+dDp6ayqnllZ9
         5to8sDYwirXCoOz0PbszUyaC8DREgT/dfPS6g8vJ89zryspGMlxlcq1UBaPs2+yj+Kvu
         Rt3nf/LouN/SP+LlzlYgZ1WWnCc8CpdC3ij3CZjXxCaok11ChEaGVE2OQ7M1A2OX4XDU
         JriKAnjAEfaSHQ6Jjgcp+vqpaK7MSGmd4B+01sAExy9i7zYd6d0Jc62ilZ58lAFgZc9d
         ufVbMcQApq8Cq6gvPKZNK/6lL0CU7e7nxzbbIyfB1doRdCEnVJb/5FMhzGJsLFPzAWE4
         /a9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9UxlXW8eSftfBkssz5z2+JXdOPbgaPnxgzGt1orbpSt+s2EQ3EvKPEiJP5wUdAOpQDg5OxWynG034=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/NdCCbqA4MjSpfbZ4M5Mjh11lDKUYcA3uxUBbhN9D8dajwdj
	YLVgq0xihvDtyvoiWH88fjXw9lmb/+OIq4yQGpxa9ToNVZm4+6jB5iyE1LQEPTTGOZ9rOla3hyI
	ZczfGdaMLQ8l5YclLYh2+ULmRveuTaMws7kzDMQjdJQ==
X-Gm-Gg: AeBDieujMSkqcNnVNO6lovQ3NRnubMw+KbrcDNrFw72kG6LAv5s9TKgriV6eMl77lR5
	6lrCJYwKY2Dhi/v9i4w5KdmyoH2O2BPCE4wUjmvn0r5lw4uTnIjja5G9k+OepGOFaEvY2TRzMsj
	hTzQPkUiZz7wp2CS//kcivMe2FJZ8+LwS0LCnV1IuzJE8r4Ssk2OJuNnE1FNJ8cbGUUVjCLkYBN
	/9+fYxAwfCkhI09lHGvBmvLYddhPrvOftUUUKv3hzID7RJnrC5219KyzNF9B13V/FR7od9PnIBi
	EdQ7WCNN0vHSBN71aP5gAbdJGnpF
X-Received: by 2002:a05:690e:4811:b0:651:bcc9:50cd with SMTP id
 956f58d0204a3-653107ccddamr6102177d50.5.1776604455299; Sun, 19 Apr 2026
 06:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323160052.17528-1-vineeth@bitbyteword.org> <20260418190456.631df6f3@fedora>
In-Reply-To: <20260418190456.631df6f3@fedora>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Sun, 19 Apr 2026 09:14:04 -0400
X-Gm-Features: AQROBzCejbUFLEO14GEr24qqxXnlBQ97NPzS668jjkdcYvI-3kvv1xuemSCQk44
Message-ID: <CAO7JXPh+__EWsW8fsKi4T+w0jdPxZEfCLQno_ukJk2=d2s0WKA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] tracepoint: Avoid double static_branch
 evaluation at guarded call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	dev@openvswitch.org, Jiri Pirko <jiri@resnulli.us>, Oded Gabbay <ogabbay@kernel.org>, 
	Koby Elbaz <koby.elbaz@intel.com>, dri-devel@lists.freedesktop.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Len Brown <lenb@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	SeongJae Park <sj@kernel.org>, linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 7:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 23 Mar 2026 12:00:19 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
>
> >   if (trace_foo_enabled() && cond)
> >       trace_call__foo(args);   /* calls __do_trace_foo() directly */
>
> Hi Vineeth,
>
> Could you rebase this series on top of 7.1-rc1 when it comes out?
> Several of these patches were accepted already. Obviously drop those.
> They were the patches that added the feature, and any where the
> maintainer acked the patch.
>
> Now that the feature has been accepted, if you post the patch series
> again after 7.1-rc1 with all the patches that haven't been accepted
> yet, then the maintainers can simply take them directly. As the feature
> is now accepted, there's no dependency on it, and they don't need to go
> through the tracing tree.
>
Sure, will do. Thanks for merging this feature.

Thanks,
Vineeth
